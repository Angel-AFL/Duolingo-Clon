import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/primary_button.dart';

/// Barra de feedback tras comprobar un ejercicio, con el boton continuar.
class LessonFeedbackBar extends StatelessWidget {
  const LessonFeedbackBar({
    super.key,
    required this.isCorrect,
    required this.answerText,
    required this.onContinue,
  });

  final bool isCorrect;
  final String answerText;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final Color color = isCorrect ? AppColors.eagerGreen : AppColors.heartPink;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s16,
        AppSpacing.s16,
        AppSpacing.s16,
        AppSpacing.s24,
      ),
      color: color.withValues(alpha: 0.15),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: color,
                  size: 32,
                ),
                const SizedBox(width: AppSpacing.s12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        isCorrect ? l10n.correct : l10n.correctAnswer,
                        style: AppTypography.subheading(color: color),
                      ),
                      if (!isCorrect && answerText.isNotEmpty)
                        Text(
                          answerText,
                          style: AppTypography.body(
                            color: AppColors.paperWhite,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.s16),
            PrimaryButton(label: l10n.continueLabel, onPressed: onContinue),
          ],
        ),
      ),
    );
  }
}
