import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';

/// Vista de error con boton de reintento para pantallas que cargan datos.
class ErrorRetryView extends StatelessWidget {
  const ErrorRetryView({
    super.key,
    required this.onRetry,
    this.title = 'No se pudieron cargar los datos',
    this.message,
  });

  final VoidCallback onRetry;
  final String title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.cloud_off_rounded,
              color: AppColors.pencilGray,
              size: 48,
            ),
            const SizedBox(height: AppSpacing.s16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.subheading(color: AppColors.paperWhite),
            ),
            if (message != null) ...<Widget>[
              const SizedBox(height: AppSpacing.s8),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: AppTypography.caption(color: AppColors.pencilGray),
              ),
            ],
            const SizedBox(height: AppSpacing.s24),
            SizedBox(
              height: 52,
              child: OutlinedButton(
                onPressed: onRetry,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.paperWhite,
                  side: const BorderSide(
                    color: AppColors.darkBorder,
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.standard),
                  ),
                ),
                child: Text(
                  'REINTENTAR',
                  style: AppTypography.label(color: AppColors.paperWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
