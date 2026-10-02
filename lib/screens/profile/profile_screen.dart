import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/formatters.dart';
import '../../l10n/app_localizations.dart';
import '../../models/friend_streak.dart';
import '../../models/profile_info.dart';
import '../../models/user_stats.dart';
import '../../providers/auth_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/streak_provider.dart';
import '../../providers/user_stats_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/error_retry_view.dart';
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

  Future<void> _confirmSignOut(BuildContext context) async {
    final AuthProvider auth = context.read<AuthProvider>();
    final AppLocalizations l10n = AppLocalizations.of(context);
    final bool confirmed =
        await showDialog<bool>(
          context: context,
          builder: (BuildContext dialogContext) => AlertDialog(
            backgroundColor: AppColors.darkSurface,
            title: Text(
              l10n.signOut,
              style: AppTypography.subheading(color: AppColors.paperWhite),
            ),
            content: Text(
              l10n.signOutConfirm,
              style: AppTypography.body(color: AppColors.pencilGray),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(
                  l10n.cancel.toUpperCase(),
                  style: AppTypography.label(color: AppColors.pencilGray),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(
                  l10n.signOut.toUpperCase(),
                  style: AppTypography.label(color: AppColors.heartPink),
                ),
              ),
            ],
          ),
        ) ??
        false;
    if (confirmed) await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final UserStats stats = context.watch<UserStatsProvider>().stats;
    final ProfileProvider profileProvider = context.watch<ProfileProvider>();
    final ProfileInfo profile = profileProvider.profile;
    final List<FriendStreak> friendStreaks = context
        .watch<StreakProvider>()
        .friendStreaks;
    final AppLocalizations l10n = AppLocalizations.of(context);

    if (!profileProvider.hasLoaded) {
      if (profileProvider.hasError) {
        return ErrorRetryView(
          title: l10n.profileLoadError,
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
                  l10n.joinedOn(profile.handle, profile.joinedYear),
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
                            l10n.addFriends.toUpperCase(),
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
                SectionLabel(label: l10n.summary),
                const SizedBox(height: AppSpacing.s16),
                _Summary(stats: stats, profile: profile),
                const SizedBox(height: AppSpacing.s24),
                SectionLabel(label: l10n.friendStreaks),
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
                  label: l10n.superFamily,
                  trailing: TextButton(
                    onPressed: () {},
                    child: Text(
                      l10n.manage.toUpperCase(),
                      style: AppTypography.label(color: AppColors.sparkBlue),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.s24),
                SizedBox(
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: () => _confirmSignOut(context),
                    icon: const Icon(Icons.logout_rounded),
                    label: Text(
                      l10n.signOut.toUpperCase(),
                      style: AppTypography.label(color: AppColors.heartPink),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.heartPink,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialStats extends StatelessWidget {
  const _SocialStats({required this.profile});

  final ProfileInfo profile;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

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
            label: l10n.courses,
          ),
        ),
        Expanded(
          child: _SocialStat(
            value: '${profile.following}',
            label: l10n.following,
          ),
        ),
        Expanded(
          child: _SocialStat(
            value: '${profile.followers}',
            label: l10n.followers,
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
    final AppLocalizations l10n = AppLocalizations.of(context);

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _SummaryItem(
                icon: Icons.local_fire_department_rounded,
                color: AppColors.streakOrange,
                label: l10n.daysCount(formatThousands(stats.streakDays)),
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
                label: l10n.expValue(formatThousands(profile.totalExp)),
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
