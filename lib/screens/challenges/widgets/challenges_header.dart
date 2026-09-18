import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../widgets/duo_mascot.dart';
import '../../../widgets/progress_bar.dart';

/// Cabecera azul de los desafios con la mascota y el progreso del mes.
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
    return Container(
      width: double.infinity,
      color: AppColors.sparkBlue,
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
                      'Desafío de $month',
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
                        '$daysLeft DÍAS',
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
                          'Gana $pointsTarget puntos de desafío',
                          style: AppTypography.subheading(
                            color: AppColors.paperWhite,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.s12),
                        ProgressBar(
                          value: points.toDouble(),
                          target: pointsTarget.toDouble(),
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
