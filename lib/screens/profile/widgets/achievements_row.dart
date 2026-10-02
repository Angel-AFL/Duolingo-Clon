import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/profile_showcase.dart';

/// Fila horizontal de logros con su valor.
class AchievementsRow extends StatelessWidget {
  const AchievementsRow({super.key, required this.achievements});

  final List<Achievement> achievements;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: achievements.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: AppSpacing.s16),
        itemBuilder: (BuildContext context, int index) =>
            _AchievementBadge(achievement: achievements[index]),
      ),
    );
  }
}

class _AchievementBadge extends StatelessWidget {
  const _AchievementBadge({required this.achievement});

  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      height: 90,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            width: 76,
            height: 76,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: achievement.color.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(AppRadius.button),
              border: Border.all(color: achievement.color, width: 2),
            ),
            child: Icon(achievement.icon, color: achievement.color, size: 34),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s12,
                vertical: AppSpacing.unit,
              ),
              decoration: BoxDecoration(
                color: achievement.color,
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                '${achievement.value}',
                style: AppTypography.label(color: AppColors.paperWhite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
