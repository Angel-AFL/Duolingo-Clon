import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/duo_mascot.dart';
import '../../../widgets/progress_bar.dart';

/// Cabecera naranja de los desafios con el progreso del mes.
class ChallengesHeader extends StatelessWidget {
  const ChallengesHeader({
    super.key,
    required this.month,
    required this.daysLeft,
    required this.points,
    required this.pointsTarget,
  });

  final String month;
  final int daysLeft;
  final int points;
  final int pointsTarget;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      color: AppColors.streakOrange,
      child: SafeArea(
        bottom: false,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.s16,
                AppSpacing.s12,
                AppSpacing.s16,
                AppSpacing.s16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 220),
                    child: Text(
                      l10n.challengeOf(month),
                      style: AppTypography.screenTitle(
                        color: AppColors.paperWhite,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s8),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.schedule_rounded,
                        size: 18,
                        color: AppColors.paperWhite,
                      ),
                      const SizedBox(width: AppSpacing.s8),
                      Text(
                        l10n.daysLeftShort(daysLeft),
                        style: AppTypography.label(color: AppColors.paperWhite),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.s16),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.s16),
                    decoration: BoxDecoration(
                      color: AppColors.darkCard,
                      borderRadius: BorderRadius.circular(AppRadius.standard),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l10n.earnPoints(pointsTarget),
                          style: AppTypography.subheading(
                            color: AppColors.paperWhite,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s12),
                        ProgressBar(
                          value: points.toDouble(),
                          target: pointsTarget.toDouble(),
                          color: AppColors.streakOrange,
                          unit: 'pts',
                          showCompletionIcon: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              right: AppSpacing.s8,
              top: 0,
              child: DuoMascot(size: 96),
            ),
          ],
        ),
      ),
    );
  }
}
