import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
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
    final button = SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.eagerGreen,
          foregroundColor: AppColors.paperWhite,
          disabledBackgroundColor: AppColors.fadedGray,
          disabledForegroundColor: AppColors.paperWhite,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.standard),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
        ),
        child: Text(
          label.toUpperCase(),
          textAlign: TextAlign.center,
          style: AppTypography.navLabel(color: AppColors.paperWhite),
        ),
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
