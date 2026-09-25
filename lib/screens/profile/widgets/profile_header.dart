import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/avatar_preset.dart';
import '../../../models/profile_info.dart';

/// Cabecera amarilla del perfil con avatar y badge Súper.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.profile,
    this.onCustomize,
    this.isUpdatingAvatar = false,
  });

  final ProfileInfo profile;

  /// Se dispara al tocar el perchero para cambiar la foto de perfil.
  final VoidCallback? onCustomize;

  final bool isUpdatingAvatar;

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
                  IconButton(
                    onPressed: onCustomize,
                    tooltip: 'Cambiar foto',
                    icon: const Icon(
                      Icons.checkroom_rounded,
                      color: AppColors.nightInk,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.unit),
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
              Center(
                child: _ProfileAvatar(
                  avatarUrl: profile.avatarUrl,
                  isUpdating: isUpdatingAvatar,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({this.avatarUrl, this.isUpdating = false});

  final String? avatarUrl;
  final bool isUpdating;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          ClipOval(
            child: SizedBox(
              width: 150,
              height: 150,
              child: _avatarImage(),
            ),
          ),
          if (isUpdating)
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x66000000),
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.paperWhite,
                  ),
                ),
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

  Widget _avatarImage() {
    final String? url = avatarUrl;

    final AvatarPreset? preset = AvatarPreset.fromStorageKey(url);
    if (preset != null) {
      return Container(
        color: preset.color,
        alignment: Alignment.center,
        child: Icon(preset.icon, color: AppColors.paperWhite, size: 80),
      );
    }

    if (url != null && url.startsWith('http')) {
      return Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _placeholder(),
      );
    }

    if (url != null && url.startsWith('assets/')) {
      return Image.asset(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _placeholder(),
      );
    }

    return _placeholder();
  }

  Widget _placeholder() {
    return Container(
      color: AppColors.avatarSkin,
      alignment: Alignment.center,
      child: const Icon(
        Icons.person_rounded,
        size: 100,
        color: AppColors.nightInk,
      ),
    );
  }
}
