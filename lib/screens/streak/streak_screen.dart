import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/formatters.dart';
import '../../models/friend_streak.dart';
import '../../models/streak_calendar.dart';
import '../../providers/streak_provider.dart';
import '../../providers/user_stats_provider.dart';
import '../../widgets/avatar_circle.dart';
import 'widgets/streak_calendar_view.dart';

/// Pantalla de detalle de racha (boceto `rachas.jpeg`).
///
/// Se abre desde el perfil y se muestra sin el bottom nav.
class StreakScreen extends StatelessWidget {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              const _TopBar(),
              const TabBar(
                labelColor: AppColors.sparkBlue,
                unselectedLabelColor: AppColors.pencilGray,
                indicatorColor: AppColors.sparkBlue,
                indicatorWeight: 3,
                dividerColor: AppColors.darkBorder,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                  fontSize: 14,
                ),
                tabs: <Widget>[
                  Tab(text: 'PERSONAL'),
                  Tab(text: 'AMIGOS'),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: <Widget>[_PersonalTab(), _FriendsTab()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s8,
        vertical: AppSpacing.s8,
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.close_rounded, color: AppColors.paperWhite),
          ),
          Expanded(
            child: Text(
              'Días de racha',
              textAlign: TextAlign.center,
              style: AppTypography.subheading(color: AppColors.paperWhite),
            ),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.ios_share_rounded, color: AppColors.paperWhite),
          ),
        ],
      ),
    );
  }
}

class _PersonalTab extends StatelessWidget {
  const _PersonalTab();

  @override
  Widget build(BuildContext context) {
    final int streakDays = context.watch<UserStatsProvider>().stats.streakDays;
    final StreakCalendar calendar = context.watch<StreakProvider>().calendar;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.s16),
      children: <Widget>[
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.s16,
              vertical: AppSpacing.s8,
            ),
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(AppRadius.standard),
            ),
            child: Text(
              'SOCIEDAD DE RACHAS EXTENSAS',
              style: AppTypography.label(color: AppColors.pencilGray),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.s16),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    formatThousands(streakDays),
                    style: AppTypography.displayLarge(
                      color: AppColors.paperWhite,
                    ),
                  ),
                  Text(
                    'días de racha',
                    style: AppTypography.headingSm(color: AppColors.pencilGray),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.local_fire_department_rounded,
              size: 140,
              color: AppColors.darkSurface,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s24),
        Container(
          padding: const EdgeInsets.all(AppSpacing.s16),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(AppRadius.standard),
          ),
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.celebration_rounded,
                color: AppColors.podiumGold,
                size: 36,
              ),
              const SizedBox(width: AppSpacing.s16),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: AppTypography.body(color: AppColors.paperWhite),
                    children: <TextSpan>[
                      const TextSpan(text: 'Has mantenido una '),
                      TextSpan(
                        text: 'Racha perfecta',
                        style: AppTypography.body(
                          color: AppColors.streakDeep,
                        ).copyWith(fontWeight: FontWeight.w800),
                      ),
                      TextSpan(
                        text:
                            ' durante ${calendar.perfectWeeks} semanas. ¡Impresionante!',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s24),
        StreakCalendarView(calendar: calendar, streakDays: streakDays),
      ],
    );
  }
}

class _FriendsTab extends StatelessWidget {
  const _FriendsTab();

  @override
  Widget build(BuildContext context) {
    final List<FriendStreak> friendStreaks = context
        .watch<StreakProvider>()
        .friendStreaks;

    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.s16),
      itemCount: friendStreaks.length,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: AppSpacing.s12),
      itemBuilder: (BuildContext context, int index) {
        final FriendStreak streak = friendStreaks[index];
        return Row(
          children: <Widget>[
            AvatarCircle(
              label: streak.name,
              color: streak.avatarColor,
              size: 52,
            ),
            const SizedBox(width: AppSpacing.s16),
            Expanded(
              child: Text(
                streak.name,
                style: AppTypography.subheading(color: AppColors.paperWhite),
              ),
            ),
            const Icon(
              Icons.local_fire_department_rounded,
              color: AppColors.streakOrange,
              size: 20,
            ),
            const SizedBox(width: AppSpacing.unit),
            Text(
              '${streak.days}',
              style: AppTypography.subheading(color: AppColors.paperWhite),
            ),
          ],
        );
      },
    );
  }
}
