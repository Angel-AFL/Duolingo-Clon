import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../models/league_entry.dart';
import '../../providers/league_provider.dart';
import 'widgets/league_header.dart';
import 'widgets/league_row.dart';

/// Pantalla de liga (boceto `liga.jpeg`, tema oscuro).
class LeagueScreen extends StatelessWidget {
  const LeagueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LeagueProvider league = context.watch<LeagueProvider>();
    final List<LeagueEntry> entries = league.entries;

    return Column(
      children: <Widget>[
        LeagueHeader(title: league.leagueName, daysLeft: league.daysLeft),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.s8),
            itemCount: entries.length,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: AppSpacing.s8),
            itemBuilder: (BuildContext context, int index) {
              final LeagueEntry entry = entries[index];
              final bool isLast = index == entries.length - 1;
              final bool alt = index.isOdd && !entry.isCurrentUser;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: alt ? AppColors.leagueRowAlt : null,
                    borderRadius: BorderRadius.circular(AppRadius.standard),
                  ),
                  child: LeagueRow(
                    entry: entry,
                    promotionExp: isLast ? 360 : null,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
