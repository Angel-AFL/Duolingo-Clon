import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

/// Banner azul de seccion/etapa actual con progreso de la unidad.
class SectionBanner extends StatelessWidget {
  const SectionBanner({
    super.key,
    required this.stage,
    required this.title,
    this.progress = 0,
  });

  final String stage;
  final String title;

  /// Progreso de la unidad (0..1) mostrado en la barra inferior.
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: AppColors.sparkBlue,
        borderRadius: BorderRadius.circular(AppRadius.standard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      stage.toUpperCase(),
                      style: AppTypography.caption(
                        color: AppColors.paperWhite.withValues(alpha: 0.85),
                      ).copyWith(letterSpacing: 0.8),
                    ),
                    const SizedBox(height: AppSpacing.s8),
                    Text(
                      title,
                      style: AppTypography.subheading(
                        color: AppColors.paperWhite,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 44,
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                color: AppColors.paperWhite.withValues(alpha: 0.4),
              ),
              const Icon(
                Icons.menu_book_rounded,
                color: AppColors.paperWhite,
                size: 28,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s16),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: SizedBox(
              height: 8,
              child: Stack(
                children: <Widget>[
                  const Positioned.fill(
                    child: ColoredBox(color: AppColors.sparkBlueLip),
                  ),
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      begin: 0,
                      end: progress.clamp(0.0, 1.0),
                    ),
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeOut,
                    builder:
                        (BuildContext context, double value, Widget? child) {
                          return FractionallySizedBox(
                            widthFactor: value,
                            child: const ColoredBox(
                              color: AppColors.paperWhite,
                            ),
                          );
                        },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
