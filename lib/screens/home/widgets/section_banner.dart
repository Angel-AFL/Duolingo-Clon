import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

/// Banner azul de seccion/etapa actual (boceto `home.jpeg`).
class SectionBanner extends StatelessWidget {
  const SectionBanner({super.key, required this.stage, required this.title});

  final String stage;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s16),
      decoration: BoxDecoration(
        color: AppColors.sparkBlue,
        borderRadius: BorderRadius.circular(AppRadius.standard),
      ),
      child: Row(
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
                  style: AppTypography.subheading(color: AppColors.paperWhite),
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
    );
  }
}
