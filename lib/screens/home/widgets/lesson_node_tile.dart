import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../models/lesson_node.dart';

/// Nodo circular del camino de aprendizaje.
class LessonNodeTile extends StatelessWidget {
  const LessonNodeTile({super.key, required this.node, this.onTap});

  final LessonNode node;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool isActive = node.status == LessonNodeStatus.active;
    final bool isCompleted = node.status == LessonNodeStatus.completed;

    final Color fill = isActive
        ? AppColors.sparkBlue
        : isCompleted
        ? AppColors.eagerGreen
        : AppColors.lockedNode;
    final Color iconColor = isActive || isCompleted
        ? AppColors.paperWhite
        : AppColors.pathLockedText;

    return Align(
      alignment: Alignment(node.horizontalOffset, 0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: fill,
            boxShadow: isActive
                ? <BoxShadow>[
                    BoxShadow(
                      color: AppColors.sparkBlue.withValues(alpha: 0.45),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Icon(node.icon, color: iconColor, size: 32),
        ),
      ),
    );
  }
}
