import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/formatters.dart';
import '../../../models/league_entry.dart';
import '../../../widgets/avatar_circle.dart';

/// Fila de la tabla de la liga con podio, avatar y EXP.
class LeagueRow extends StatelessWidget {
  const LeagueRow({super.key, required this.entry, this.promotionExp});

  final LeagueEntry entry;

  /// Si se indica, muestra la tarjeta flotante "+EXP" (zona de ascenso).
  final int? promotionExp;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s16,
            vertical: AppSpacing.s12,
          ),
          decoration: BoxDecoration(
            color: entry.isCurrentUser ? AppColors.darkCard : null,
            borderRadius: BorderRadius.circular(AppRadius.standard),
          ),
          child: Row(
            children: <Widget>[
              _RankBadge(rank: entry.rank),
              const SizedBox(width: AppSpacing.s12),
              AvatarCircle(
                label: entry.name,
                color: entry.avatarColor,
                size: 52,
              ),
              const SizedBox(width: AppSpacing.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      entry.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.subheading(
                        color: AppColors.paperWhite,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.unit),
                    Row(
                      children: <Widget>[
                        Text(entry.flag, style: const TextStyle(fontSize: 16)),
                        const SizedBox(width: AppSpacing.s8),
                        Text(
                          '${entry.courseCount}',
                          style: AppTypography.caption(
                            color: AppColors.pencilGray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.s8),
              Text(
                '${formatThousands(entry.exp)} EXP',
                style: AppTypography.subheading(
                  color: entry.isCurrentUser
                      ? AppColors.leaguePurple
                      : AppColors.pencilGray,
                ),
              ),
            ],
          ),
        ),
        if (promotionExp != null)
          Positioned(
            right: AppSpacing.s16,
            bottom: -AppSpacing.s12,
            child: _PromotionCard(exp: promotionExp!),
          ),
      ],
    );
  }
}

class _PromotionCard extends StatelessWidget {
  const _PromotionCard({required this.exp});

  final int exp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s12,
        vertical: AppSpacing.s8,
      ),
      decoration: BoxDecoration(
        color: AppColors.heartPink,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.bolt_rounded, color: AppColors.paperWhite, size: 18),
          const SizedBox(width: AppSpacing.unit),
          Text(
            '+$exp EXP',
            style: AppTypography.label(color: AppColors.paperWhite),
          ),
        ],
      ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.rank});

  final int rank;

  Color? get _medalColor {
    switch (rank) {
      case 1:
        return AppColors.podiumGold;
      case 2:
        return AppColors.podiumSilver;
      case 3:
        return AppColors.podiumBronze;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color? medal = _medalColor;
    if (medal == null) {
      return SizedBox(
        width: 28,
        child: Text(
          '$rank',
          textAlign: TextAlign.center,
          style: AppTypography.subheading(color: AppColors.pencilGray),
        ),
      );
    }

    return SizedBox(
      width: 28,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.workspace_premium_rounded, color: medal, size: 28),
          Text(
            '$rank',
            style: AppTypography.caption(color: AppColors.paperWhite),
          ),
        ],
      ),
    );
  }
}
