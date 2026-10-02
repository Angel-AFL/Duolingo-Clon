import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../models/profile_showcase.dart';

/// Fila horizontal de medallas mensuales.
class MedalsRow extends StatelessWidget {
  const MedalsRow({super.key, required this.medals});

  final List<MonthlyMedal> medals;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: medals.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: AppSpacing.s16),
        itemBuilder: (BuildContext context, int index) =>
            _Medal(medal: medals[index]),
      ),
    );
  }
}

class _Medal extends StatelessWidget {
  const _Medal({required this.medal});

  final MonthlyMedal medal;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: medal.color.withValues(alpha: 0.16),
        border: Border.all(color: medal.color, width: 3),
      ),
      child: Icon(medal.icon, color: medal.color, size: 32),
    );
  }
}
