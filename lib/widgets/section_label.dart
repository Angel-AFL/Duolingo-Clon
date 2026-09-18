import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

/// Encabezado de seccion en mayusculas con tracking y accion opcional.
///
/// Ej. "DESAFIOS DEL DIA" o "SUPER FAMILIA ... ADMINISTRAR".
class SectionLabel extends StatelessWidget {
  const SectionLabel({super.key, required this.label, this.trailing});

  final String label;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label.toUpperCase(),
            style: AppTypography.label(color: AppColors.pencilGray),
          ),
        ),
        ?trailing,
      ],
    );
  }
}
