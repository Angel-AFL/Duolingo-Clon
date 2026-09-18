import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';

/// Avatar placeholder: circulo de color con la inicial.
///
/// Mientras no existan los assets reales de avatar, se usa este widget para
/// la liga, las rachas entre amigos y el perfil.
class AvatarCircle extends StatelessWidget {
  const AvatarCircle({
    super.key,
    required this.label,
    required this.color,
    this.size = 56,
    this.borderColor,
    this.borderWidth = 0,
  });

  /// Inicial (o texto corto) mostrada en el centro.
  final String label;

  final Color color;
  final double size;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: borderColor == null
            ? null
            : Border.all(color: borderColor!, width: borderWidth),
      ),
      child: Text(
        label.isEmpty ? '' : label.substring(0, 1).toUpperCase(),
        style: AppTypography.headingSm(
          color: AppColors.paperWhite,
        ).copyWith(fontSize: size * 0.42),
      ),
    );
  }
}
