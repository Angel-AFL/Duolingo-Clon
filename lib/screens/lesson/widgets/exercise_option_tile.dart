import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

/// Estado visual de una opcion de ejercicio.
enum ExerciseOptionState { idle, selected, correct, wrong }

/// Opcion seleccionable reutilizada por los ejercicios de opcion multiple
/// y de completar la oracion.
class ExerciseOptionTile extends StatelessWidget {
  const ExerciseOptionTile({
    super.key,
    required this.label,
    required this.state,
    this.onTap,
  });

  final String label;
  final ExerciseOptionState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color border;
    final Color background;
    final Color text;
    switch (state) {
      case ExerciseOptionState.selected:
        border = AppColors.sparkBlue;
        background = AppColors.sparkBlue.withValues(alpha: 0.15);
        text = AppColors.sparkBlue;
      case ExerciseOptionState.correct:
        border = AppColors.eagerGreen;
        background = AppColors.eagerGreen.withValues(alpha: 0.18);
        text = AppColors.eagerGreen;
      case ExerciseOptionState.wrong:
        border = AppColors.heartPink;
        background = AppColors.heartPink.withValues(alpha: 0.18);
        text = AppColors.heartPink;
      case ExerciseOptionState.idle:
        border = AppColors.darkBorder;
        background = AppColors.darkSurface;
        text = AppColors.paperWhite;
    }

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(AppRadius.standard),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.standard),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s16,
            vertical: AppSpacing.s16,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: border, width: 2),
            borderRadius: BorderRadius.circular(AppRadius.standard),
          ),
          child: Text(
            label,
            style: AppTypography.body(
              color: text,
            ).copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
