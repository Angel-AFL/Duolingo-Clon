import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/lesson_exercise.dart';
import '../../../providers/lesson_provider.dart';

/// Ejercicio de banco de palabras: armar la traduccion tocando fichas.
class WordBankExercise extends StatelessWidget {
  const WordBankExercise({super.key, required this.exercise});

  final LessonExercise exercise;

  @override
  Widget build(BuildContext context) {
    final LessonProvider provider = context.watch<LessonProvider>();
    final List<String> selected = provider.selectedWords;

    final Color borderColor = !provider.isAnswered
        ? AppColors.darkBorder
        : provider.isCorrect
        ? AppColors.eagerGreen
        : AppColors.heartPink;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.s16),
      children: <Widget>[
        Text(
          'Traduce esta oración',
          style: AppTypography.label(color: AppColors.pencilGray),
        ),
        const SizedBox(height: AppSpacing.s12),
        Text(
          exercise.prompt,
          style: AppTypography.headingSm(color: AppColors.paperWhite),
        ),
        const SizedBox(height: AppSpacing.s24),
        Container(
          constraints: const BoxConstraints(minHeight: 96),
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.s12),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(AppRadius.standard),
          ),
          child: selected.isEmpty
              ? Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Toca las palabras para formar la oración',
                    style: AppTypography.caption(color: AppColors.pencilGray),
                  ),
                )
              : Wrap(
                  spacing: AppSpacing.s8,
                  runSpacing: AppSpacing.s8,
                  children: <Widget>[
                    for (final String word in selected)
                      _WordChip(
                        label: word,
                        selected: true,
                        onTap: provider.isAnswered
                            ? null
                            : () => provider.toggleWord(word),
                      ),
                  ],
                ),
        ),
        const SizedBox(height: AppSpacing.s24),
        Wrap(
          spacing: AppSpacing.s8,
          runSpacing: AppSpacing.s8,
          children: <Widget>[
            for (final String word in exercise.options)
              _WordChip(
                label: word,
                dimmed: selected.contains(word),
                onTap: provider.isAnswered || selected.contains(word)
                    ? null
                    : () => provider.toggleWord(word),
              ),
          ],
        ),
      ],
    );
  }
}

class _WordChip extends StatelessWidget {
  const _WordChip({
    required this.label,
    this.selected = false,
    this.dimmed = false,
    this.onTap,
  });

  final String label;
  final bool selected;
  final bool dimmed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Color border = selected ? AppColors.sparkBlue : AppColors.darkBorder;
    final Color text = dimmed
        ? AppColors.pathLockedText
        : selected
        ? AppColors.sparkBlue
        : AppColors.paperWhite;

    return Material(
      color: dimmed ? Colors.transparent : AppColors.darkSurface,
      borderRadius: BorderRadius.circular(AppRadius.standard),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.standard),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s12,
            vertical: AppSpacing.s8,
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
