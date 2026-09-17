import 'package:flutter/material.dart';

import '../core/theme/app_typography.dart';

/// Valor compacto de la barra superior: icono/bandera + numero.
class StatChip extends StatelessWidget {
  const StatChip({
    super.key,
    required this.leading,
    required this.value,
    this.valueColor,
  });

  final Widget leading;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        leading,
        const SizedBox(width: 6),
        Text(value, style: AppTypography.statValue(color: valueColor)),
      ],
    );
  }
}
