import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Avatar predefinido: color de fondo + icono.
///
/// Se persiste en `profiles.avatar_url` con la clave `preset:<id>` para no
/// subir binarios al Storage. El prefijo [keyPrefix] distingue un preset de
/// una URL (`https://...`) o de una ruta de asset (`assets/...`).
class AvatarPreset {
  const AvatarPreset({
    required this.id,
    required this.color,
    required this.icon,
  });

  final String id;
  final Color color;
  final IconData icon;

  /// Clave con la que se guarda este preset en `profiles.avatar_url`.
  String get storageKey => '$keyPrefix$id';

  static const String keyPrefix = 'preset:';

  static const List<AvatarPreset> all = <AvatarPreset>[
    AvatarPreset(
      id: 'owl',
      color: AppColors.eagerGreen,
      icon: Icons.emoji_nature_rounded,
    ),
    AvatarPreset(
      id: 'paw',
      color: AppColors.streakOrange,
      icon: Icons.pets_rounded,
    ),
    AvatarPreset(
      id: 'smile',
      color: AppColors.sparkBlue,
      icon: Icons.sentiment_satisfied_alt_rounded,
    ),
    AvatarPreset(
      id: 'game',
      color: AppColors.leaguePurple,
      icon: Icons.sports_esports_rounded,
    ),
    AvatarPreset(
      id: 'music',
      color: AppColors.superPink,
      icon: Icons.music_note_rounded,
    ),
    AvatarPreset(
      id: 'rocket',
      color: AppColors.gemBlue,
      icon: Icons.rocket_launch_rounded,
    ),
    AvatarPreset(
      id: 'star',
      color: AppColors.podiumGold,
      icon: Icons.star_rounded,
    ),
    AvatarPreset(
      id: 'heart',
      color: AppColors.heartPink,
      icon: Icons.favorite_rounded,
    ),
  ];

  /// Preset a partir de su id, o `null` si no existe.
  static AvatarPreset? byId(String id) {
    for (final AvatarPreset preset in all) {
      if (preset.id == id) return preset;
    }
    return null;
  }

  /// Preset referenciado por un valor de `avatar_url`, o `null` si no es uno.
  static AvatarPreset? fromStorageKey(String? value) {
    if (value == null || !value.startsWith(keyPrefix)) return null;
    return byId(value.substring(keyPrefix.length));
  }
}
