import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/avatar_preset.dart';
import '../../../providers/profile_provider.dart';

/// Abre la hoja inferior para cambiar la foto de perfil.
Future<void> showAvatarPickerSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.darkSurface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppRadius.standard),
      ),
    ),
    builder: (BuildContext context) => const _AvatarPickerSheet(),
  );
}

/// Presets, galeria y camara para elegir el avatar.
class _AvatarPickerSheet extends StatelessWidget {
  const _AvatarPickerSheet();

  bool get _supportsCamera =>
      kIsWeb ||
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;

  Future<void> _pick(BuildContext context, ImageSource source) async {
    final ProfileProvider provider = context.read<ProfileProvider>();
    final NavigatorState navigator = Navigator.of(context);
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    try {
      final XFile? file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      if (file == null) return;
      final Uint8List bytes = await file.readAsBytes();
      final String name = file.name;
      final String extension = name.contains('.')
          ? name.split('.').last
          : 'jpg';
      await provider.updateAvatarFromBytes(bytes, extension);
      if (navigator.mounted) navigator.pop();
    } catch (error) {
      messenger.showSnackBar(
        SnackBar(content: Text('No se pudo cambiar la foto: $error')),
      );
    }
  }

  Future<void> _selectPreset(BuildContext context, AvatarPreset preset) async {
    final ProfileProvider provider = context.read<ProfileProvider>();
    final NavigatorState navigator = Navigator.of(context);
    await provider.selectPresetAvatar(preset);
    if (navigator.mounted) navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final bool isUpdating = context.watch<ProfileProvider>().isUpdatingAvatar;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.darkBorder,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.s16),
            Text(
              'Elige tu foto',
              style: AppTypography.subheading(color: AppColors.paperWhite),
            ),
            const SizedBox(height: AppSpacing.s16),
            Wrap(
              spacing: AppSpacing.s12,
              runSpacing: AppSpacing.s12,
              children: AvatarPreset.all
                  .map(
                    (AvatarPreset preset) => _PresetTile(
                      preset: preset,
                      enabled: !isUpdating,
                      onTap: () => _selectPreset(context, preset),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: AppSpacing.s24),
            Row(
              children: <Widget>[
                Expanded(
                  child: _SourceButton(
                    icon: Icons.photo_library_rounded,
                    label: 'GALERÍA',
                    enabled: !isUpdating,
                    onTap: () => _pick(context, ImageSource.gallery),
                  ),
                ),
                if (_supportsCamera) ...<Widget>[
                  const SizedBox(width: AppSpacing.s12),
                  Expanded(
                    child: _SourceButton(
                      icon: Icons.photo_camera_rounded,
                      label: 'CÁMARA',
                      enabled: !isUpdating,
                      onTap: () => _pick(context, ImageSource.camera),
                    ),
                  ),
                ],
              ],
            ),
            if (isUpdating) ...<Widget>[
              const SizedBox(height: AppSpacing.s16),
              const Center(
                child: CircularProgressIndicator(color: AppColors.eagerGreen),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PresetTile extends StatelessWidget {
  const _PresetTile({
    required this.preset,
    required this.enabled,
    required this.onTap,
  });

  final AvatarPreset preset;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: preset.color,
        ),
        child: Icon(preset.icon, color: AppColors.paperWhite, size: 30),
      ),
    );
  }
}

class _SourceButton extends StatelessWidget {
  const _SourceButton({
    required this.icon,
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton.icon(
        onPressed: enabled ? onTap : null,
        icon: Icon(icon),
        label: Text(
          label,
          style: AppTypography.label(color: AppColors.paperWhite),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.paperWhite,
          side: const BorderSide(color: AppColors.darkBorder, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.standard),
          ),
        ),
      ),
    );
  }
}
