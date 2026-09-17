import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';

/// CTA secundario del skill: relleno transparente, texto Spark Blue,
/// radio 12px y borde grueso de 2px en Faded Gray.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
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
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.sparkBlue,
          side: const BorderSide(color: AppColors.fadedGray, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.standard),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
        ),
        child: Text(
          label.toUpperCase(),
          textAlign: TextAlign.center,
          style: AppTypography.navLabel(color: AppColors.sparkBlue),
        ),
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
