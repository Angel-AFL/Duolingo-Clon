import 'dart:async';

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
      if (nodes.isNotEmpty) _nodes = List<LessonNode>.of(nodes);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Marca el nodo activo como completado y activa el siguiente.
  void completeCurrent() {
    final int index = activeIndex;
    if (index == -1 || index + 1 >= _nodes.length) return;

    _nodes[index] = LessonNode(
      type: _nodes[index].type,
      status: LessonNodeStatus.completed,
      horizontalOffset: _nodes[index].horizontalOffset,
    );
    _nodes[index + 1] = LessonNode(
      type: _nodes[index + 1].type,
      status: LessonNodeStatus.active,
      horizontalOffset: _nodes[index + 1].horizontalOffset,
    );
    notifyListeners();
    unawaited(_repository.saveNodes(_nodes));
  }
}
