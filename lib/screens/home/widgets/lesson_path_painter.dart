import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/lesson_node.dart';

/// Dibuja el sendero serpenteante que une los nodos del camino.
class LessonPathPainter extends CustomPainter {
  const LessonPathPainter({
    required this.nodes,
    required this.rowHeight,
    required this.nodeSize,
  });

  final List<LessonNode> nodes;
  final double rowHeight;
  final double nodeSize;

  Offset _center(int index, Size size) {
    final double travel = (size.width - nodeSize) / 2;
    final double x = size.width / 2 + nodes[index].horizontalOffset * travel;
    final double y = rowHeight * index + rowHeight / 2;
    return Offset(x, y);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (nodes.length < 2) return;

    final Paint paint = Paint()
      ..color = AppColors.darkBorder.withValues(alpha: 0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final Path path = Path();
    final Offset first = _center(0, size);
    path.moveTo(first.dx, first.dy);
    for (int i = 1; i < nodes.length; i++) {
      final Offset prev = _center(i - 1, size);
      final Offset cur = _center(i, size);
      final double midY = (prev.dy + cur.dy) / 2;
      path.cubicTo(prev.dx, midY, cur.dx, midY, cur.dx, cur.dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant LessonPathPainter oldDelegate) {
    return oldDelegate.nodes != nodes ||
        oldDelegate.rowHeight != rowHeight ||
        oldDelegate.nodeSize != nodeSize;
  }
}
