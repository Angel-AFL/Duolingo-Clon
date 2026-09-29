import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../widgets/primary_button.dart';

/// Pantalla de resultado que se muestra al terminar la leccion.
class LessonResultView extends StatelessWidget {
  const LessonResultView({
    super.key,
    required this.correctCount,
    required this.total,
    required this.exp,
    required this.onContinue,
  });

  final int correctCount;
  final int total;
  final int exp;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final int accuracy = total == 0
        ? 0
        : ((correctCount / total) * 100).round();

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.s24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.emoji_events_rounded,
            color: AppColors.podiumGold,
            size: 96,
          ),
          const SizedBox(height: AppSpacing.s24),
          Text(
            '¡Lección completada!',
            textAlign: TextAlign.center,
            style: AppTypography.headingSm(color: AppColors.paperWhite),
          ),
          const SizedBox(height: AppSpacing.s8),
          Text(
            'Sigue así, cada lección te acerca a tu meta.',
            textAlign: TextAlign.center,
            style: AppTypography.body(color: AppColors.pencilGray),
          ),
          const SizedBox(height: AppSpacing.s32),
          Row(
            children: <Widget>[
              Expanded(
                child: _ResultStat(
                  label: 'EXP TOTAL',
                  value: '+$exp',
                  color: AppColors.podiumGold,
                ),
              ),
              const SizedBox(width: AppSpacing.s12),
              Expanded(
                child: _ResultStat(
                  label: 'PRECISIÓN',
                  value: '$accuracy%',
                  color: AppColors.eagerGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s40),
          PrimaryButton(label: 'Continuar', onPressed: onContinue),
        ],
      ),
    );
  }
}

class _ResultStat extends StatelessWidget {
  const _ResultStat({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(AppRadius.standard),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        children: <Widget>[
          Text(label, style: AppTypography.label(color: AppColors.pencilGray)),
          const SizedBox(height: AppSpacing.s8),
          Text(value, style: AppTypography.headingSm(color: color)),
        ],
      ),
    );
  }
}
