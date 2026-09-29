import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/daily_challenge.dart';
import '../../../widgets/progress_bar.dart';

/// Reto diario: titulo, barra de progreso y cofre de recompensa.
class DailyChallengeTile extends StatelessWidget {
  const DailyChallengeTile({super.key, required this.challenge});

  final DailyChallenge challenge;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                challenge.title,
                style: AppTypography.subheading(color: AppColors.paperWhite),
              ),
              const SizedBox(height: AppSpacing.s12),
              ProgressBar(
                value: challenge.progress.toDouble(),
                target: challenge.target.toDouble(),
                unit: challenge.metric == ChallengeMetric.exp ? 'EXP' : null,
                showCompletionIcon: true,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.s16),
        _RewardChest(
          reward: challenge.reward,
          isComplete: challenge.isComplete,
        ),
      ],
    );
  }
}

class _RewardChest extends StatelessWidget {
  const _RewardChest({required this.reward, required this.isComplete});

  final ChallengeReward reward;
  final bool isComplete;

  Color get _color {
    switch (reward) {
      case ChallengeReward.wood:
        return AppColors.streakDeep;
      case ChallengeReward.silver:
        return AppColors.podiumSilver;
      case ChallengeReward.gold:
        return AppColors.podiumGold;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isComplete ? _color.withValues(alpha: 0.35) : _color,
        borderRadius: BorderRadius.circular(AppRadius.standard),
        border: isComplete
            ? Border.all(color: AppColors.eagerGreen, width: 2)
            : null,
      ),
      child: Icon(
        isComplete ? Icons.check_circle_rounded : Icons.inventory_2_rounded,
        color: isComplete ? AppColors.eagerGreen : AppColors.paperWhite,
        size: 26,
      ),
    );
  }
}
