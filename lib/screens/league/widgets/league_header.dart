import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

/// Cabecera con gradiente de la liga (boceto `liga.jpeg`).
class LeagueHeader extends StatelessWidget {
  const LeagueHeader({super.key, required this.title, required this.daysLeft});

  final String title;
  final int daysLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            AppColors.leagueGradientStart,
            AppColors.leagueGradientEnd,
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s16,
            AppSpacing.s12,
            AppSpacing.s16,
            AppSpacing.s24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: AppTypography.screenTitle(color: AppColors.paperWhite),
              ),
              const SizedBox(height: AppSpacing.s8),
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.schedule_rounded,
                    size: 18,
                    color: AppColors.paperWhite,
                  ),
                  const SizedBox(width: AppSpacing.s8),
                  Text(
                    '$daysLeft DÍAS',
                    style: AppTypography.label(color: AppColors.paperWhite),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.s16),
              const Center(child: _Trophy()),
            ],
          ),
        ),
      ),
    );
  }
}

class _Trophy extends StatelessWidget {
  const _Trophy();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ShaderMask(
            shaderCallback: (Rect bounds) => const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: <Color>[
                AppColors.podiumGold,
                AppColors.leaguePurple,
                AppColors.sparkBlue,
              ],
            ).createShader(bounds),
            child: const Icon(
              Icons.emoji_events_rounded,
              size: 120,
              color: AppColors.paperWhite,
            ),
          ),
          const Positioned(
            top: 8,
            right: 12,
            child: Icon(
              Icons.auto_awesome,
              size: 22,
              color: AppColors.paperWhite,
            ),
          ),
          const Positioned(
            bottom: 12,
            left: 16,
            child: Icon(
              Icons.auto_awesome,
              size: 16,
              color: AppColors.paperWhite,
            ),
          ),
        ],
      ),
    );
  }
}
