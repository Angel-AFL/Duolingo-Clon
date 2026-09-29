import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

/// Barra de progreso de la leccion, fiel a Duolingo.
///
/// Se divide en un segmento por ejercicio: verde para aciertos, rojo para
/// errores y el color de fondo para los pendientes. Avanza al pulsar
/// continuar (ver `LessonProvider.next`).
class LessonProgressBar extends StatelessWidget {
  const LessonProgressBar({super.key, required this.results, this.height = 16});

  /// Resultado por ejercicio: null = pendiente, true = acierto, false = error.
  final List<bool?> results;

  final double height;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: SizedBox(
        height: height,
        child: Row(
          children: <Widget>[
            for (final bool? result in results)
              Expanded(child: ColoredBox(color: _colorFor(result))),
          ],
        ),
      ),
    );
  }

  Color _colorFor(bool? result) {
    switch (result) {
      case true:
        return AppColors.eagerGreen;
      case false:
        return AppColors.heartPink;
      case null:
        return AppColors.progressTrack;
    }
  }
}
