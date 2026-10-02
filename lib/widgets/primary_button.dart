import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

/// CTA primario del skill: relleno Eager Green, texto blanco en mayusculas,
/// radio 12px y sin borde. La accion se comunica solo con el color.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final Widget button = ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label.toUpperCase(),
        textAlign: TextAlign.center,
        style: AppTypography.navLabel(color: AppColors.paperWhite),
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
