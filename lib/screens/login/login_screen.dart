import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../widgets/duo_mascot.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/secondary_button.dart';

/// Pantalla de bienvenida (tema claro, segun el skill).
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.onGetStarted});

  final VoidCallback onGetStarted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paperWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s24,
            vertical: AppSpacing.s16,
          ),
          child: Column(
            children: <Widget>[
              const Spacer(flex: 2),
              const DuoMascot(size: 140),
              const SizedBox(height: AppSpacing.s16),
              Text(
                'duolingo',
                style: AppTypography.display(color: AppColors.eagerGreen),
              ),
              const SizedBox(height: AppSpacing.s12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: Text(
                  'The free, fun, and effective way to learn a language!',
                  textAlign: TextAlign.center,
                  style: AppTypography.body(color: AppColors.pencilGray),
                ),
              ),
              const Spacer(flex: 3),
              const Icon(
                Icons.arrow_downward_rounded,
                size: 56,
                color: AppColors.heartPink,
              ),
              const SizedBox(height: AppSpacing.s16),
              PrimaryButton(
                label: 'Get started',
                onPressed: onGetStarted,
              ),
              const SizedBox(height: AppSpacing.s12),
              SecondaryButton(
                label: 'I already have an account',
                onPressed: onGetStarted,
              ),
              const SizedBox(height: AppSpacing.s8),
            ],
          ),
        ),
      ),
    );
  }
}
