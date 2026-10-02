import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/lesson_exercise.dart';
import '../../../providers/lesson_provider.dart';
import '../../../widgets/duo_choice_tile.dart';
import 'exercise_option_tile.dart';

/// Ejercicio de emparejar: unir cada palabra en español con su traducción.
class MatchPairsExercise extends StatelessWidget {
  const MatchPairsExercise({super.key, required this.exercise});

  final LessonExercise exercise;

  @override
  Widget build(BuildContext context) {
    final LessonProvider provider = context.watch<LessonProvider>();
    final List<String> rights = exercise.pairs
        .map((ExercisePair p) => p.right)
        .toList()
        .reversed
        .toList();

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.s16),
      children: <Widget>[
        Text(
          AppLocalizations.of(context).matchPairs,
          style: AppTypography.label(color: AppColors.pencilGray),
        ),
        const SizedBox(height: AppSpacing.s12),
        Text(
          exercise.prompt,
          style: AppTypography.headingSm(color: AppColors.paperWhite),
        ),
        const SizedBox(height: AppSpacing.s24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  for (final ExercisePair pair in exercise.pairs)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.s12),
                      child: _PairTile(
                        label: pair.left,
                        state: _leftState(provider, pair.left),
                        onTap:
                            provider.isAnswered ||
                                provider.matches.containsKey(pair.left)
                            ? null
                            : () => provider.tapMatchLeft(pair.left),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.s12),
            Expanded(
              child: Column(
                children: <Widget>[
                  for (final String right in rights)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.s12),
                      child: _PairTile(
                        label: right,
                        state: _rightState(provider, right),
                        onTap: provider.isAnswered
                            ? null
                            : () => provider.tapMatchRight(right),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  ExerciseOptionState _leftState(LessonProvider provider, String left) {
    if (provider.matches.containsKey(left)) {
      return ExerciseOptionState.correct;
    }
    if (provider.wrongLeft == left) return ExerciseOptionState.wrong;
    if (provider.pendingLeft == left) return ExerciseOptionState.selected;
    return ExerciseOptionState.idle;
  }

  ExerciseOptionState _rightState(LessonProvider provider, String right) {
    if (provider.matches.values.contains(right)) {
      return ExerciseOptionState.correct;
    }
    if (provider.wrongRight == right) return ExerciseOptionState.wrong;
    return ExerciseOptionState.idle;
  }
}

/// Ficha de una palabra (izquierda o derecha) del ejercicio de emparejar.
class _PairTile extends StatelessWidget {
  const _PairTile({required this.label, required this.state, this.onTap});

  final String label;
  final ExerciseOptionState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DuoChoiceTile(
      label: label,
      state: _map(state),
      onTap: onTap,
      centerLabel: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s12,
        vertical: AppSpacing.s16,
      ),
    );
  }

  DuoChoiceState _map(ExerciseOptionState state) {
    switch (state) {
      case ExerciseOptionState.idle:
        return DuoChoiceState.idle;
      case ExerciseOptionState.selected:
        return DuoChoiceState.selected;
      case ExerciseOptionState.correct:
        return DuoChoiceState.correct;
      case ExerciseOptionState.wrong:
        return DuoChoiceState.wrong;
    }
  }
}
