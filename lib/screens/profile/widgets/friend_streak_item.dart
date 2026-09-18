import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/friend_streak.dart';
import '../../../widgets/avatar_circle.dart';

/// Avatar de un amigo con los dias de racha compartida.
class FriendStreakItem extends StatelessWidget {
  const FriendStreakItem({super.key, required this.streak, this.onTap});

  final FriendStreak streak;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.standard),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AvatarCircle(
              label: streak.name,
              color: streak.avatarColor,
              size: 60,
            ),
            const SizedBox(height: AppSpacing.s8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.local_fire_department_rounded,
                  color: AppColors.pencilGray,
                  size: 16,
                ),
                const SizedBox(width: AppSpacing.unit),
                Text(
                  '${streak.days}',
                  style: AppTypography.subheading(color: AppColors.pencilGray),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
