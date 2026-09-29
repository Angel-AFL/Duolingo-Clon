import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/repositories/lesson_repository.dart';
import '../models/lesson_exercise.dart';

/// Estado de una sesion de leccion: ejercicios, progreso y respuestas.
class LessonProvider extends ChangeNotifier {
  LessonProvider({LessonRepository? repository})
    : _repository = repository ?? MockLessonRepository();

  final LessonRepository _repository;

  List<LessonExercise> _exercises = <LessonExercise>[];
  bool _isLoading = false;
  String? _error;

  int _index = 0;
  int _correctCount = 0;
  bool _isAnswered = false;
  bool _isCorrect = false;
  bool _isFinished = false;

  /// Resultado por ejercicio: null = pendiente, true = acierto, false = error.
  List<bool?> _results = <bool?>[];

  String? _selectedOption;
  final List<String> _selectedWords = <String>[];
  final Map<String, String> _matches = <String, String>{};
  String? _pendingLeft;
  String? _wrongLeft;
  String? _wrongRight;
  Timer? _wrongTimer;

  List<LessonExercise> get exercises =>
      List<LessonExercise>.unmodifiable(_exercises);
  bool get isLoading => _isLoading;
  String? get error => _error;

  int get index => _index;
  LessonExercise? get current =>
      _index >= 0 && _index < _exercises.length ? _exercises[_index] : null;
  int get total => _exercises.length;
  int get correctCount => _correctCount;
  bool get isAnswered => _isAnswered;
  bool get isCorrect => _isCorrect;
  bool get isFinished => _isFinished;

  /// Estado de cada ejercicio para la barra de progreso.
  List<bool?> get results => List<bool?>.unmodifiable(_results);

  double get progress => _exercises.isEmpty
      ? 0
      : (_results.where((bool? r) => r != null).length / _exercises.length)
            .clamp(0.0, 1.0);

  String? get selectedOption => _selectedOption;
  List<String> get selectedWords => List<String>.unmodifiable(_selectedWords);
  Map<String, String> get matches => Map<String, String>.unmodifiable(_matches);
  String? get pendingLeft => _pendingLeft;
  String? get wrongLeft => _wrongLeft;
  String? get wrongRight => _wrongRight;

  bool get canCheck {
    final LessonExercise? exercise = current;
    if (exercise == null || _isAnswered) return false;
    switch (exercise.type) {
      case LessonExerciseType.multipleChoice:
      case LessonExerciseType.fillBlank:
        return _selectedOption != null;
      case LessonExerciseType.wordBank:
        return _selectedWords.isNotEmpty;
      case LessonExerciseType.matchPairs:
        return false;
    }
  }

  /// Carga los ejercicios de la leccion y reinicia la sesion.
  Future<void> start(int lessonPosition) async {
    reset();
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final List<LessonExercise> exercises = await _repository.fetchExercises(
        lessonPosition,
      );
      _exercises = List<LessonExercise>.of(exercises);
      _results = List<bool?>.filled(_exercises.length, null);
      if (_exercises.isEmpty) {
        _error = 'Esta lección todavía no tiene ejercicios.';
      }
    } catch (_) {
      _error = 'No se pudieron cargar los ejercicios.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _wrongTimer?.cancel();
    _exercises = <LessonExercise>[];
    _isLoading = false;
    _error = null;
    _index = 0;
    _correctCount = 0;
    _isAnswered = false;
    _isCorrect = false;
    _isFinished = false;
    _results = <bool?>[];
    _clearSelection();
  }

  void selectOption(String option) {
    if (_isAnswered) return;
    _selectedOption = option;
    notifyListeners();
  }

  void toggleWord(String word) {
    if (_isAnswered) return;
    if (_selectedWords.contains(word)) {
      _selectedWords.remove(word);
    } else {
      _selectedWords.add(word);
    }
    notifyListeners();
  }

  /// Selecciona una palabra del lado izquierdo (español).
  void tapMatchLeft(String left) {
    if (_isAnswered || _matches.containsKey(left)) return;
    _pendingLeft = left;
    notifyListeners();
  }

  /// Empareja con una palabra del lado derecho (inglés).
  void tapMatchRight(String right) {
    final LessonExercise? exercise = current;
    if (exercise == null || _isAnswered) return;
    final String? left = _pendingLeft;
    if (left == null) return;

    ExercisePair? pair;
    for (final ExercisePair candidate in exercise.pairs) {
      if (candidate.left == left) {
        pair = candidate;
        break;
      }
    }
    if (pair != null && pair.right == right) {
      _matches[left] = right;
      _pendingLeft = null;
      if (_matches.length == exercise.pairs.length) {
        _isAnswered = true;
        _isCorrect = true;
        _correctCount++;
      }
      notifyListeners();
      return;
    }

    _pendingLeft = null;
    _wrongLeft = left;
    _wrongRight = right;
    notifyListeners();
    _wrongTimer?.cancel();
    _wrongTimer = Timer(const Duration(milliseconds: 600), () {
      _wrongLeft = null;
      _wrongRight = null;
      notifyListeners();
    });
  }

  /// Evalua la respuesta actual (seleccion multiple, banco o completar).
  void check() {
    final LessonExercise? exercise = current;
    if (exercise == null || _isAnswered || !canCheck) return;

    final bool correct;
    switch (exercise.type) {
      case LessonExerciseType.multipleChoice:
      case LessonExerciseType.fillBlank:
        correct = exercise.answer.contains(_selectedOption);
      case LessonExerciseType.wordBank:
        correct = listEquals(_selectedWords, exercise.answer);
      case LessonExerciseType.matchPairs:
        return;
    }

    _isAnswered = true;
    _isCorrect = correct;
    if (correct) _correctCount++;
    notifyListeners();
  }

  /// Avanza al siguiente ejercicio o finaliza la leccion.
  ///
  /// La barra de progreso avanza aqui (al pulsar continuar): se registra el
  /// resultado del ejercicio actual antes de pasar al siguiente.
  void next() {
    if (_isFinished) return;
    if (_index >= 0 && _index < _results.length) {
      _results[_index] = _isCorrect;
    }
    if (_index + 1 >= _exercises.length) {
      _isFinished = true;
      notifyListeners();
      return;
    }
    _index++;
    _isAnswered = false;
    _isCorrect = false;
    _clearSelection();
    notifyListeners();
  }

  /// Respuesta correcta en texto para el feedback.
  String get correctAnswerText {
    final LessonExercise? exercise = current;
    if (exercise == null) return '';
    if (exercise.type == LessonExerciseType.matchPairs) {
      return '¡Bien hecho!';
    }
    return exercise.answer.join(' ');
  }

  void _clearSelection() {
    _selectedOption = null;
    _selectedWords.clear();
    _matches.clear();
    _pendingLeft = null;
    _wrongLeft = null;
    _wrongRight = null;
  }

  @override
  void dispose() {
    _wrongTimer?.cancel();
    super.dispose();
  }
}
