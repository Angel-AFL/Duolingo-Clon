import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/profile_info.dart';

/// Cabecera amarilla del perfil con avatar y badge Súper.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.profile});

  final ProfileInfo profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.profileYellow,
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
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      profile.name,
                      style: AppTypography.screenTitle(
                        color: AppColors.nightInk,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.checkroom_rounded,
                    color: AppColors.nightInk,
                    size: 26,
                  ),
                  const SizedBox(width: AppSpacing.s16),
                  const Icon(
                    Icons.settings_rounded,
                    color: AppColors.nightInk,
                    size: 26,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.unit),
              Text(
                'En Súper desde ${profile.superSince}',
                style: AppTypography.subheading(
                  color: AppColors.nightInk.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: AppSpacing.s8),
              const Center(child: _ProfileAvatar()),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.avatarSkin,
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 100,
              color: AppColors.nightInk,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s12,
                vertical: AppSpacing.unit,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: <Color>[AppColors.superPink, AppColors.superViolet],
                ),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                'SÚPER',
                style: AppTypography.caption(
                  color: AppColors.paperWhite,
                ).copyWith(fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
