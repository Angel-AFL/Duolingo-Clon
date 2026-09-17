import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../models/lesson_node.dart';
import '../../../providers/learning_path_provider.dart';
import '../../../widgets/duo_mascot.dart';
import 'lesson_node_tile.dart';

/// Camino sinuoso de lecciones con la mascota a un costado.
class LessonPath extends StatelessWidget {
  const LessonPath({super.key, this.onNodeTap});

  final ValueChanged<LessonNode>? onNodeTap;

  @override
  Widget build(BuildContext context) {
    final List<LessonNode> nodes =
        context.watch<LearningPathProvider>().nodes;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Column(
          children: <Widget>[
            for (final LessonNode node in nodes)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.s8,
                ),
                child: LessonNodeTile(
                  node: node,
                  onTap: onNodeTap == null ? null : () => onNodeTap!(node),
                ),
              ),
          ],
        ),
        const Positioned(
          left: 0,
          top: 130,
          child: DuoMascot(size: 108),
        ),
      ],
    );
  }
}
