import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/formatters.dart';
import '../../models/friend_streak.dart';
import '../../models/profile_info.dart';
import '../../models/user_stats.dart';
import '../../providers/profile_provider.dart';
import '../../providers/streak_provider.dart';
import '../../providers/user_stats_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/section_label.dart';
import 'widgets/avatar_picker_sheet.dart';
import 'widgets/friend_streak_item.dart';
import 'widgets/profile_header.dart';

/// Pantalla de perfil (boceto `perfil.jpeg`, tema oscuro).
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _openStreak(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.streak);
  }

  @override
  Widget build(BuildContext context) {
    final UserStats stats = context.watch<UserStatsProvider>().stats;
    final ProfileProvider profileProvider = context.watch<ProfileProvider>();
    final ProfileInfo profile = profileProvider.profile;
    final List<FriendStreak> friendStreaks = context
        .watch<StreakProvider>()
        .friendStreaks;

    if (!profileProvider.hasLoaded) {
      if (profileProvider.hasError) {
        return _ProfileError(
          message: profileProvider.error,
          onRetry: profileProvider.load,
        );
      }
      if (profileProvider.isLoading) {
        return const Center(
          child: CircularProgressIndicator(color: AppColors.eagerGreen),
        );
      }
    }

    return Column(
      children: <Widget>[
        ProfileHeader(
          profile: profile,
          isUpdatingAvatar: profileProvider.isUpdatingAvatar,
          onCustomize: () => showAvatarPickerSheet(context),
        ),
        Expanded(
          child: RefreshIndicator(
            color: AppColors.eagerGreen,
            backgroundColor: AppColors.darkSurface,
            onRefresh: profileProvider.load,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.s16,
                AppSpacing.s16,
                AppSpacing.s16,
                AppSpacing.s24,
              ),
              children: <Widget>[
                Text(
                  '${profile.handle} · SE UNIÓ EN ${profile.joinedYear}',
                  style: AppTypography.label(color: AppColors.pencilGray),
                ),
                const SizedBox(height: AppSpacing.s24),
                _SocialStats(profile: profile),
                const SizedBox(height: AppSpacing.s24),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.person_add_alt_1_rounded),
                          label: Text(
                            'AGREGA AMIGOS',
                            style: AppTypography.label(
                              color: AppColors.paperWhite,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.paperWhite,
                            side: const BorderSide(
                              color: AppColors.darkBorder,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppRadius.standard,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.s12),
                    SizedBox(
                      width: 52,
                      height: 52,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          foregroundColor: AppColors.paperWhite,
                          side: const BorderSide(
                            color: AppColors.darkBorder,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppRadius.standard,
                            ),
                          ),
                        ),
                        child: const Icon(Icons.qr_code_2_rounded),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.s24),
                const SectionLabel(label: 'Resumen'),
                const SizedBox(height: AppSpacing.s16),
                _Summary(stats: stats, profile: profile),
                const SizedBox(height: AppSpacing.s24),
                const SectionLabel(label: 'Rachas entre amigos'),
                const SizedBox(height: AppSpacing.s16),
                SizedBox(
                  height: 108,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: friendStreaks.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(width: AppSpacing.s8),
                    itemBuilder: (BuildContext context, int index) {
                      final FriendStreak streak = friendStreaks[index];
                      return FriendStreakItem(
                        streak: streak,
                        onTap: () => _openStreak(context),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.s24),
                SectionLabel(
                  label: 'Súper familia',
                  trailing: TextButton(
                    onPressed: () {},
                    child: Text(
                      'ADMINISTRAR',
                      style: AppTypography.label(color: AppColors.sparkBlue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileError extends StatelessWidget {
  const _ProfileError({required this.onRetry, this.message});

  final VoidCallback onRetry;
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
              'No se pudo cargar el perfil',
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

class _SocialStats extends StatelessWidget {
  const _SocialStats({required this.profile});

  final ProfileInfo profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _SocialStat(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('🇺🇸', style: TextStyle(fontSize: 20)),
                const SizedBox(width: AppSpacing.unit),
                Text(
                  '+${profile.courses}',
                  style: AppTypography.caption(color: AppColors.pencilGray),
                ),
              ],
            ),
            label: 'Cursos',
          ),
        ),
        Expanded(
          child: _SocialStat(value: '${profile.following}', label: 'Siguiendo'),
        ),
        Expanded(
          child: _SocialStat(
            value: '${profile.followers}',
            label: 'Seguidores',
          ),
        ),
      ],
    );
  }
}

class _SocialStat extends StatelessWidget {
  const _SocialStat({this.value, this.leading, required this.label});

  final String? value;
  final Widget? leading;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (value != null)
          Text(
            value!,
            style: AppTypography.subheading(color: AppColors.paperWhite),
          )
        else
          leading!,
        const SizedBox(height: AppSpacing.unit),
        Text(label, style: AppTypography.caption(color: AppColors.pencilGray)),
      ],
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.stats, required this.profile});

  final UserStats stats;
  final ProfileInfo profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _SummaryItem(
                icon: Icons.local_fire_department_rounded,
                color: AppColors.streakOrange,
                label: '${formatThousands(stats.streakDays)} días',
              ),
            ),
            Expanded(
              child: _SummaryItem(
                leading: Text(
                  stats.courseFlag,
                  style: const TextStyle(fontSize: 22),
                ),
                label: '${stats.courseCount}',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s16),
        Row(
          children: <Widget>[
            Expanded(
              child: _SummaryItem(
                icon: Icons.diamond_rounded,
                color: AppColors.gemBlue,
                label: profile.league,
              ),
            ),
            Expanded(
              child: _SummaryItem(
                icon: Icons.bolt_rounded,
                color: AppColors.podiumGold,
                label: '${formatThousands(profile.totalExp)} EXP',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    this.icon,
    this.leading,
    this.color = AppColors.paperWhite,
    required this.label,
  });

  final IconData? icon;
  final Widget? leading;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (icon != null) Icon(icon, color: color, size: 24) else leading!,
        const SizedBox(width: AppSpacing.s8),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.subheading(color: AppColors.paperWhite),
          ),
        ),
      ],
    );
  }
}
