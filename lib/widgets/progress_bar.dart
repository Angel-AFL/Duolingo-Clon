import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';

/// Barra de progreso redondeada con etiqueta centrada opcional.
///
/// Se usa en los retos del dia y en la liga. Al completar la meta cambia al
/// color de exito y puede mostrar un check.
class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.value,
    this.target = 100,
    this.color = AppColors.sparkBlue,
    this.completeColor = AppColors.eagerGreen,
    this.height = 16,
    this.showLabel = true,
    this.unit,
    this.showCompletionIcon = false,
  });

  /// Progreso actual.
  final double value;

  /// Meta a alcanzar.
  final double target;

  final Color color;

  /// Color del relleno al alcanzar la meta.
  final Color completeColor;

  final double height;
  final bool showLabel;

  /// Sufijo de la etiqueta (ej. "EXP").
  final String? unit;

  /// Muestra un check cuando se alcanza la meta.
  final bool showCompletionIcon;

  @override
  Widget build(BuildContext context) {
    final double progress = target <= 0 ? 0 : (value / target).clamp(0.0, 1.0);
    final bool isComplete = progress >= 1.0;
    final Color fillColor = isComplete ? completeColor : color;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: SizedBox(
        height: height,
        child: Stack(
          children: <Widget>[
            const Positioned.fill(
              child: ColoredBox(color: AppColors.progressTrack),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: progress),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              builder: (BuildContext context, double animated, Widget? child) {
                return FractionallySizedBox(
                  widthFactor: animated,
                  child: ColoredBox(color: fillColor),
                );
              },
            ),
            if (showLabel)
              Positioned.fill(
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (isComplete && showCompletionIcon) ...<Widget>[
                        Icon(
                          Icons.check_circle_rounded,
                          size: height * 0.85,
                          color: AppColors.paperWhite,
                        ),
                        const SizedBox(width: AppSpacing.unit),
                      ],
                      Text(
                        _label,
                        style: AppTypography.caption(
                          color: AppColors.paperWhite,
                        ).copyWith(fontSize: height * 0.75),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String get _label {
    final String base = '${_format(value)} / ${_format(target)}';
    return unit == null ? base : '$base $unit';
  }

  static String _format(double number) {
    return number == number.roundToDouble()
        ? number.round().toString()
        : number.toString();
  }
}
