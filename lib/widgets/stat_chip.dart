import 'package:flutter/material.dart';

import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';

/// Valor compacto de la barra superior: icono/bandera + numero.
class StatChip extends StatelessWidget {
  const StatChip({
    super.key,
    required this.leading,
    required this.value,
    this.valueColor,
    this.onTap,
  });

  final Widget leading;
  final String value;
  final Color? valueColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        leading,
        const SizedBox(width: 6),
        Text(value, style: AppTypography.statValue(color: valueColor)),
      ],
    );

    if (onTap == null) return content;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.standard),
      child: content,
    );
  }
}
