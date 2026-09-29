import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../data/repositories/learning_path_repository.dart';
import '../models/lesson_node.dart';

/// Estado del camino de aprendizaje.
class LearningPathProvider extends ChangeNotifier {
  LearningPathProvider({LearningPathRepository? repository})
    : _repository = repository ?? MockLearningPathRepository();

  final LearningPathRepository _repository;

  List<LessonNode> _nodes = List<LessonNode>.of(MockData.lessonPath);
  bool _isLoading = false;

  List<LessonNode> get nodes => List<LessonNode>.unmodifiable(_nodes);
  bool get isLoading => _isLoading;

  int get activeIndex =>
      _nodes.indexWhere((LessonNode n) => n.status == LessonNodeStatus.active);

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    try {
      final List<LessonNode> nodes = await _repository.fetchNodes();
      if (nodes.isNotEmpty) {
        _nodes = List<LessonNode>.of(nodes)
          ..sort(
            (LessonNode a, LessonNode b) => a.position.compareTo(b.position),
          );
        _ensureActive();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Si no hay nodo activo y quedan pendientes, activa el primero.
  ///
  /// Corrige datos imperfectos (p. ej. todos en `completed`); no persiste, la
  /// migracion `0006_reset_lesson_progress.sql` es la que arregla la fila.
  void _ensureActive() {
    if (activeIndex != -1) return;
    final int pending = _nodes.indexWhere(
      (LessonNode n) => n.status != LessonNodeStatus.completed,
    );
    if (pending == -1) return;
    _nodes[pending] = _nodes[pending].copyWith(status: LessonNodeStatus.active);
  }

  /// Marca el nodo activo como completado y activa el siguiente.
  ///
  /// Si el activo es el ultimo nodo, solo lo marca como completado.
  Future<void> completeCurrent() async {
    final int index = activeIndex;
    if (index == -1) return;

    _nodes[index] = _nodes[index].copyWith(status: LessonNodeStatus.completed);
    if (index + 1 < _nodes.length) {
      _nodes[index + 1] = _nodes[index + 1].copyWith(
        status: LessonNodeStatus.active,
      );
    }
    notifyListeners();
    await _repository.saveNodes(_nodes);
  }
}
