import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../../widgets/duo_button.dart';

/// Barra de feedback tras comprobar un ejercicio.
///
/// Banda solida verde (acierto) o roja (error) que entra deslizandose, con el
/// boton continuar en relieve 3D.
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
    final Color accent = isCorrect ? AppColors.eagerGreen : AppColors.heartPink;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 1, end: 0),
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      builder: (BuildContext context, double t, Widget? child) {
        return Transform.translate(
          offset: Offset(0, t * 40),
          child: Opacity(opacity: 1 - t, child: child),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.s16,
          AppSpacing.s16,
          AppSpacing.s16,
          AppSpacing.s24,
        ),
        color: isCorrect
            ? AppColors.feedbackCorrectBg
            : AppColors.feedbackWrongBg,
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    isCorrect
                        ? Icons.check_circle_rounded
                        : Icons.cancel_rounded,
                    color: accent,
                    size: 32,
                  ),
                  const SizedBox(width: AppSpacing.s12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          isCorrect ? l10n.correct : l10n.correctAnswer,
                          style: AppTypography.subheading(color: accent),
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
              DuoButton(
                label: l10n.continueLabel,
                onPressed: onContinue,
                variant: isCorrect
                    ? DuoButtonVariant.primary
                    : DuoButtonVariant.error,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
