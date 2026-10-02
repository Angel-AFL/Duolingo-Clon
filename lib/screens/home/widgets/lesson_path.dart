import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/lesson_node.dart';
import '../../../providers/learning_path_provider.dart';
import '../../../widgets/duo_mascot.dart';
import 'lesson_node_tile.dart';
import 'lesson_path_painter.dart';

/// Camino sinuoso de lecciones con sendero y mascota.
class LessonPath extends StatelessWidget {
  const LessonPath({super.key, this.onNodeTap});

  final ValueChanged<LessonNode>? onNodeTap;

  /// Distancia vertical entre centros de nodos.
  static const double rowHeight = 118;

  @override
  Widget build(BuildContext context) {
    final List<LessonNode> nodes = context.watch<LearningPathProvider>().nodes;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned.fill(
          child: CustomPaint(
            painter: LessonPathPainter(
              nodes: nodes,
              rowHeight: rowHeight,
              nodeSize: LessonNodeTile.size,
            ),
          ),
        ),
        Column(
          children: <Widget>[
            for (final LessonNode node in nodes)
              SizedBox(
                height: rowHeight,
                child: LessonNodeTile(
                  node: node,
                  onTap: onNodeTap == null ? null : () => onNodeTap!(node),
                ),
              ),
          ],
        ),
        Positioned(
          left: 4,
          top: rowHeight * 1.4,
          child: const DuoMascot(size: 104),
        ),
      ],
    );
  }
}
