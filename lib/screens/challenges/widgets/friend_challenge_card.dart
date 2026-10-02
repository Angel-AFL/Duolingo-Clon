import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/avatar_circle.dart';
import '../../../widgets/duo_button.dart';
import '../../../widgets/progress_bar.dart';

/// Panel del reto de EXP entre amigos.
class FriendChallengeCard extends StatelessWidget {
  const FriendChallengeCard({
    super.key,
    required this.partnerName,
    required this.partnerExp,
    required this.myExp,
    required this.target,
    required this.cheered,
    required this.gifted,
    required this.onCheer,
    required this.onGift,
  });

  final String partnerName;
  final int partnerExp;
  final int myExp;
  final int target;
  final bool cheered;
  final bool gifted;
  final VoidCallback onCheer;
  final VoidCallback onGift;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final int combined = myExp + partnerExp;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: AppColors.challengePanel,
        borderRadius: BorderRadius.circular(AppRadius.button),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AvatarCircle(
                  label: l10n.you,
                  color: AppColors.sparkBlue,
                  size: 72,
                ),
                const SizedBox(width: AppSpacing.s16),
                AvatarCircle(
                  label: partnerName,
                  color: AppColors.streakDeep,
                  size: 72,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s16),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  l10n.earnExp(target),
                  style: AppTypography.subheading(color: AppColors.paperWhite),
                ),
              ),
              const SizedBox(width: AppSpacing.s12),
              const _Chest(),
            ],
          ),
          const SizedBox(height: AppSpacing.s12),
          ProgressBar(
            value: combined.toDouble(),
            target: target.toDouble(),
            color: AppColors.streakOrange,
          ),
          const SizedBox(height: AppSpacing.s16),
          _ExpRow(label: l10n.you, exp: myExp, color: AppColors.streakOrange),
          const SizedBox(height: AppSpacing.s8),
          _ExpRow(
            label: partnerName,
            exp: partnerExp,
            color: AppColors.streakDeep,
          ),
          const SizedBox(height: AppSpacing.s16),
          Row(
            children: <Widget>[
              Expanded(
                child: DuoButton(
                  label: l10n.giveCheer,
                  variant: DuoButtonVariant.secondary,
                  leading: const Text('👋', style: TextStyle(fontSize: 20)),
                  onPressed: cheered ? null : onCheer,
                ),
              ),
              const SizedBox(width: AppSpacing.s12),
              Expanded(
                child: DuoButton(
                  label: gifted ? l10n.sent : l10n.giveGift,
                  variant: DuoButtonVariant.secondary,
                  leading: const Text('🎁', style: TextStyle(fontSize: 20)),
                  onPressed: gifted ? null : onGift,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExpRow extends StatelessWidget {
  const _ExpRow({required this.label, required this.exp, required this.color});

  final String label;
  final int exp;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: AppSpacing.s12),
        Expanded(
          child: Text(
            label,
            style: AppTypography.subheading(color: AppColors.paperWhite),
          ),
        ),
        Text(
          '$exp EXP',
          style: AppTypography.subheading(color: AppColors.pencilGray),
        ),
      ],
    );
  }
}

class _Chest extends StatelessWidget {
  const _Chest();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.podiumGold,
        borderRadius: BorderRadius.circular(AppRadius.standard),
      ),
      child: const Icon(
        Icons.inventory_2_rounded,
        color: AppColors.streakDeep,
        size: 26,
      ),
    );
  }
}
