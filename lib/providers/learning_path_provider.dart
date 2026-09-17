import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../models/lesson_node.dart';

/// Estado del camino de aprendizaje.
class LearningPathProvider extends ChangeNotifier {
  final List<LessonNode> _nodes = List<LessonNode>.of(MockData.lessonPath);

  List<LessonNode> get nodes => List<LessonNode>.unmodifiable(_nodes);

  int get activeIndex =>
      _nodes.indexWhere((n) => n.status == LessonNodeStatus.active);

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
  }
}
