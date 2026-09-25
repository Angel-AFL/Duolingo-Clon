import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/formatters.dart';
import '../../../providers/user_stats_provider.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/stat_chip.dart';

/// Barra superior con bandera, racha, gemas y corazones.
class TopStatsBar extends StatelessWidget {
  const TopStatsBar({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<UserStatsProvider>().stats;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s16,
        vertical: AppSpacing.s8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          StatChip(
            leading: Text(
              stats.courseFlag,
              style: const TextStyle(fontSize: 20),
            ),
            value: '${stats.courseCount}',
            valueColor: AppColors.paperWhite,
          ),
          StatChip(
            leading: const Icon(
              Icons.local_fire_department_rounded,
              color: AppColors.streakOrange,
              size: 24,
            ),
            value: formatThousands(stats.streakDays),
            valueColor: AppColors.paperWhite,
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.streak),
          ),
          StatChip(
            leading: const Icon(
              Icons.diamond_rounded,
              color: AppColors.gemBlue,
              size: 22,
            ),
            value: formatThousands(stats.gems),
            valueColor: AppColors.paperWhite,
          ),
          StatChip(
            leading: const Icon(
              Icons.bolt_rounded,
              color: AppColors.superViolet,
              size: 24,
            ),
            value: stats.hasUnlimitedHearts ? '∞' : '5',
            valueColor: AppColors.paperWhite,
          ),
        ],
      ),
    );
  }
}
