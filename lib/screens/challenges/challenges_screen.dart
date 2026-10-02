import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/formatters.dart';
import '../../data/app_constants.dart';
import '../../l10n/app_localizations.dart';
import '../../models/daily_challenge.dart';
import '../../providers/challenges_provider.dart';
import '../../widgets/error_retry_view.dart';
import '../../widgets/section_label.dart';
import 'widgets/challenges_header.dart';
import 'widgets/challenges_skeleton.dart';
import 'widgets/daily_challenge_tile.dart';
import 'widgets/friend_challenge_card.dart';

/// Pantalla de desafios (boceto `desafios.jpeg`, tema oscuro).
class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChallengesProvider challenges = context.watch<ChallengesProvider>();
    final AppLocalizations l10n = AppLocalizations.of(context);
    final DateTime now = DateTime.now();

    return Column(
      children: <Widget>[
        ChallengesHeader(
          month: monthNameEs(now),
          daysLeft: daysLeftInMonth(now),
          points: challenges.points,
          pointsTarget: challenges.pointsTarget,
        ),
        Expanded(child: _body(context, challenges, l10n)),
      ],
    );
  }

  Widget _body(
    BuildContext context,
    ChallengesProvider challenges,
    AppLocalizations l10n,
  ) {
    if (!challenges.hasLoaded) {
      if (challenges.hasError) {
        return ErrorRetryView(
          title: l10n.challengesLoadError,
          message: challenges.error,
          onRetry: challenges.load,
        );
      }
      if (challenges.isLoading) return const ChallengesSkeleton();
    }

    final List<DailyChallenge> dailyChallenges = challenges.challenges;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.s16,
        AppSpacing.s16,
        AppSpacing.s16,
        AppSpacing.s24,
      ),
      children: <Widget>[
        SectionLabel(
          label: l10n.friendChallenge,
          trailing: _Countdown(label: l10n.friendChallengeHours),
        ),
        const SizedBox(height: AppSpacing.s12),
        FriendChallengeCard(
          partnerName: AppConstants.challengePartner,
          partnerExp: AppConstants.challengePartnerExp,
          myExp: AppConstants.challengeMineExp,
          target: AppConstants.friendChallengeTarget,
          cheered: challenges.cheered,
          gifted: challenges.gifted,
          onCheer: challenges.giveCheer,
          onGift: challenges.giveGift,
        ),
        const SizedBox(height: AppSpacing.s24),
        const Divider(color: AppColors.darkBorder, height: 1),
        const SizedBox(height: AppSpacing.s24),
        SectionLabel(
          label: l10n.dailyChallenges,
          trailing: _Countdown(label: l10n.hoursLeft),
        ),
        const SizedBox(height: AppSpacing.s8),
        if (dailyChallenges.isEmpty)
          const _EmptyChallenges()
        else
          for (final DailyChallenge challenge in dailyChallenges)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.s16),
              child: DailyChallengeTile(challenge: challenge),
            ),
      ],
    );
  }
}

class _EmptyChallenges extends StatelessWidget {
  const _EmptyChallenges();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s32),
      child: Column(
        children: <Widget>[
          const Icon(
            Icons.emoji_events_outlined,
            color: AppColors.pencilGray,
            size: 40,
          ),
          const SizedBox(height: AppSpacing.s12),
          Text(
            AppLocalizations.of(context).emptyChallenges,
            textAlign: TextAlign.center,
            style: AppTypography.body(color: AppColors.pencilGray),
          ),
        ],
      ),
    );
  }
}

/// Contador de tiempo restante junto a un encabezado de seccion.
class _Countdown extends StatelessWidget {
  const _Countdown({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Icon(
          Icons.schedule_rounded,
          size: 16,
          color: AppColors.pencilGray,
        ),
        const SizedBox(width: AppSpacing.unit),
        Text(label, style: AppTypography.label(color: AppColors.pencilGray)),
      ],
    );
  }
}
