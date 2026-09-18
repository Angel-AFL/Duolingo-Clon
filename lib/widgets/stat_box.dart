import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';

/// Caja resumen con borde: icono, valor y etiqueta.
///
/// Ej. "8 dias de practica" / "0 Protectores usados" en Rachas.
class StatBox extends StatelessWidget {
  const StatBox({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.s12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.darkBorder),
        borderRadius: BorderRadius.circular(AppRadius.standard),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: AppSpacing.s8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  value,
                  style: AppTypography.subheading(color: AppColors.paperWhite),
                ),
                Text(
                  label,
                  style: AppTypography.caption(color: AppColors.pencilGray),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
