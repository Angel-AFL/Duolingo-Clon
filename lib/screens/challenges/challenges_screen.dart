import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/mock_data.dart';
import '../../models/daily_challenge.dart';
import '../../providers/challenges_provider.dart';
import '../../widgets/section_label.dart';
import 'widgets/challenges_header.dart';
import 'widgets/daily_challenge_tile.dart';

/// Pantalla de desafios (boceto `desafios.jpeg`, tema oscuro).
class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChallengesProvider challenges = context.watch<ChallengesProvider>();

    return Column(
      children: <Widget>[
        ChallengesHeader(
          month: MockData.challengeMonth,
          daysLeft: MockData.challengeDaysLeft,
          points: challenges.points,
          pointsTarget: challenges.pointsTarget,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.s16,
              AppSpacing.s16,
              AppSpacing.s16,
              AppSpacing.s24,
            ),
            children: <Widget>[
              _PartnerRow(
                name: MockData.challengePartner,
                exp: MockData.challengePartnerExp,
              ),
              const SizedBox(height: AppSpacing.s16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _ActionButton(
                      emoji: '👋',
                      label: 'Dar toque',
                      onPressed: challenges.giveCheer,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.s12),
                  Expanded(
                    child: _ActionButton(
                      emoji: '🎁',
                      label: 'Dar regalo',
                      onPressed: challenges.giveGift,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s24),
              const Divider(color: AppColors.darkBorder, height: 1),
              const SizedBox(height: AppSpacing.s24),
              SectionLabel(
                label: 'Desafíos del día',
                trailing: Row(
                  children: <Widget>[
                    const Icon(
                      Icons.schedule_rounded,
                      size: 16,
                      color: AppColors.pencilGray,
                    ),
                    const SizedBox(width: AppSpacing.unit),
                    Text(
                      '12H',
                      style: AppTypography.label(color: AppColors.pencilGray),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.s8),
              for (final DailyChallenge challenge in challenges.challenges)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.s16),
                  child: DailyChallengeTile(challenge: challenge),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PartnerRow extends StatelessWidget {
  const _PartnerRow({required this.name, required this.exp});

  final String name;
  final int exp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(Icons.circle, size: 14, color: AppColors.sparkBlue),
        const SizedBox(width: AppSpacing.s12),
        Expanded(
          child: Text(
            name,
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

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.emoji,
    required this.label,
    required this.onPressed,
  });

  final String emoji;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.darkBorder, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.standard),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: AppSpacing.s8),
            Flexible(
              child: Text(
                label.toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.label(color: AppColors.paperWhite),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
