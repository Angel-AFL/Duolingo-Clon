/// Tipo de ejercicio dentro de una leccion.
enum LessonExerciseType { multipleChoice, wordBank, matchPairs, fillBlank }

/// Pareja palabra -> traduccion del ejercicio de emparejar.
class ExercisePair {
  const ExercisePair({required this.left, required this.right});

  final String left;
  final String right;

  factory ExercisePair.fromJson(Map<String, dynamic> json) {
    return ExercisePair(
      left: json['left'] as String,
      right: json['right'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'left': left,
    'right': right,
  };
}

/// Un ejercicio de una leccion (fila de `lesson_exercises`).
class LessonExercise {
  const LessonExercise({
    required this.type,
    required this.prompt,
    this.id = 0,
    this.options = const <String>[],
    this.answer = const <String>[],
    this.pairs = const <ExercisePair>[],
  });

  final int id;
  final LessonExerciseType type;
  final String prompt;

  /// Opciones de seleccion multiple / completar / banco de palabras.
  final List<String> options;

  /// Respuesta(s) correcta(s). En el banco de palabras respeta el orden.
  final List<String> answer;

  /// Parejas del ejercicio de emparejar.
  final List<ExercisePair> pairs;

  factory LessonExercise.fromJson(Map<String, dynamic> json) {
    return LessonExercise(
      id: json['id'] as int? ?? 0,
      type: _typeFromName(json['type'] as String),
      prompt: json['prompt'] as String,
      options: _stringList(json['options']),
      answer: _stringList(json['answer']),
      pairs: _pairList(json['pairs']),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'type': _typeName(type),
    'prompt': prompt,
    'options': options,
    'answer': answer,
    'pairs': pairs.map((ExercisePair p) => p.toJson()).toList(),
  };

  static List<String> _stringList(Object? value) {
    if (value is! List) return const <String>[];
    return value.map((Object? e) => e.toString()).toList();
  }

  static List<ExercisePair> _pairList(Object? value) {
    if (value is! List) return const <ExercisePair>[];
    return value
        .map(
          (Object? e) =>
              ExercisePair.fromJson(Map<String, dynamic>.from(e as Map)),
        )
        .toList();
  }

  static LessonExerciseType _typeFromName(String name) {
    switch (name) {
      case 'word_bank':
        return LessonExerciseType.wordBank;
      case 'match_pairs':
        return LessonExerciseType.matchPairs;
      case 'fill_blank':
        return LessonExerciseType.fillBlank;
      case 'multiple_choice':
      default:
        return LessonExerciseType.multipleChoice;
    }
  }

  static String _typeName(LessonExerciseType type) {
    switch (type) {
      case LessonExerciseType.wordBank:
        return 'word_bank';
      case LessonExerciseType.matchPairs:
        return 'match_pairs';
      case LessonExerciseType.fillBlank:
        return 'fill_blank';
      case LessonExerciseType.multipleChoice:
        return 'multiple_choice';
    }
  }
}
