import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/lesson_exercise.dart';
import '../../../providers/lesson_provider.dart';
import 'exercise_option_tile.dart';

/// Ejercicio de completar la oracion: elegir la palabra que falta.
class FillBlankExercise extends StatelessWidget {
  const FillBlankExercise({super.key, required this.exercise});

  final LessonExercise exercise;

  @override
  Widget build(BuildContext context) {
    final LessonProvider provider = context.watch<LessonProvider>();

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.s16),
      children: <Widget>[
        Text(
          AppLocalizations.of(context).completeSentence,
          style: AppTypography.label(color: AppColors.pencilGray),
        ),
        const SizedBox(height: AppSpacing.s12),
        Text(
          exercise.prompt,
          style: AppTypography.headingSm(color: AppColors.paperWhite),
        ),
        const SizedBox(height: AppSpacing.s24),
        for (final String option in exercise.options)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.s12),
            child: ExerciseOptionTile(
              label: option,
              state: _stateFor(provider, option),
              onTap: provider.isAnswered
                  ? null
                  : () => provider.selectOption(option),
            ),
          ),
      ],
    );
  }

  ExerciseOptionState _stateFor(LessonProvider provider, String option) {
    final bool selected = provider.selectedOption == option;
    if (!provider.isAnswered) {
      return selected ? ExerciseOptionState.selected : ExerciseOptionState.idle;
    }
    if (exercise.answer.contains(option)) return ExerciseOptionState.correct;
    if (selected) return ExerciseOptionState.wrong;
    return ExerciseOptionState.idle;
  }
}
