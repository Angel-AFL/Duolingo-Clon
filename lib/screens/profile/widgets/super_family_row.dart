import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/profile_showcase.dart';
import '../../../widgets/avatar_circle.dart';

/// Fila de miembros de la Súper familia dentro de un panel oscuro.
class SuperFamilyRow extends StatelessWidget {
  const SuperFamilyRow({super.key, required this.members, this.onAdd});

  final List<SuperFamilyMember> members;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(AppRadius.button),
      ),
      child: SizedBox(
        height: 56,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
          children: <Widget>[
            for (final SuperFamilyMember member in members)
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.s12),
                child: AvatarCircle(
                  label: member.name,
                  color: member.color,
                  size: 56,
                ),
              ),
            _AddMemberButton(onTap: onAdd),
          ],
        ),
      ),
    );
  }
}

class _AddMemberButton extends StatelessWidget {
  const _AddMemberButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: AppLocalizations.of(context).addMember,
      button: true,
      child: Tooltip(
        message: AppLocalizations.of(context).addMember,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.darkCard,
              border: Border.all(color: AppColors.darkBorder, width: 2),
            ),
            child: const Icon(
              Icons.add_rounded,
              color: AppColors.pencilGray,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
