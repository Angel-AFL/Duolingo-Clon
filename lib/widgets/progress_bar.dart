import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';

/// Barra de progreso redondeada con etiqueta centrada opcional.
///
/// Se usa en los retos del dia y en la liga.
class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.value,
    this.target = 100,
    this.color = AppColors.sparkBlue,
    this.height = 16,
    this.showLabel = true,
  });

  /// Progreso actual.
  final double value;

  /// Meta a alcanzar.
  final double target;

  final Color color;
  final double height;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final double progress = target <= 0 ? 0 : (value / target).clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: SizedBox(
        height: height,
        child: Stack(
          children: <Widget>[
            const Positioned.fill(
              child: ColoredBox(color: AppColors.progressTrack),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: ColoredBox(color: color),
            ),
            if (showLabel)
              Positioned.fill(
                child: Center(
                  child: Text(
                    '${_format(value)} / ${_format(target)}',
                    style: AppTypography.caption(
                      color: AppColors.paperWhite,
                    ).copyWith(fontSize: height * 0.75),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  static String _format(double number) {
    return number == number.roundToDouble()
        ? number.round().toString()
        : number.toString();
  }
}
