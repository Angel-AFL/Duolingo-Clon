import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';

/// Variantes cromaticas del boton 3D de Duolingo.
enum DuoButtonVariant {
  primary,
  secondary,
  secondaryError,
  error,
  streak,
  blue,
  purple,
}

/// Boton con relieve 3D caracteristico de Duolingo.
///
/// La cara se apoya sobre un "lip" solido (borde inferior de un tono mas
/// oscuro) que se colapsa al pulsar, dando la sensacion de tecla fisica.
/// Ver `app_spacing.dart` (`AppSpacing.lip`) y `app_colors.dart` (`*Lip`).
class DuoButton extends StatefulWidget {
  const DuoButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = DuoButtonVariant.primary,
    this.expand = true,
    this.icon,
    this.leading,
    this.height = 52,
  });

  final String label;
  final VoidCallback? onPressed;
  final DuoButtonVariant variant;
  final bool expand;
  final IconData? icon;

  /// Widget a la izquierda del texto (p. ej. un emoji); tiene prioridad
  /// sobre [icon].
  final Widget? leading;

  final double height;

  @override
  State<DuoButton> createState() => _DuoButtonState();
}

class _DuoButtonState extends State<DuoButton> {
  bool _pressed = false;

  bool get _enabled => widget.onPressed != null;

  @override
  Widget build(BuildContext context) {
    final _VariantColors colors = _VariantColors.of(widget.variant);
    final bool sunk = _pressed && _enabled;

    final Widget face = AnimatedContainer(
      duration: const Duration(milliseconds: 90),
      curve: Curves.easeOut,
      height: widget.height,
      transform: Matrix4.translationValues(0, sunk ? AppSpacing.lip : 0, 0),
      decoration: BoxDecoration(
        color: _enabled ? colors.face : AppColors.darkSurface,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: colors.border == null
            ? null
            : Border.all(color: colors.border!, width: 2),
        boxShadow: _enabled && !sunk
            ? <BoxShadow>[
                BoxShadow(
                  color: colors.lip,
                  offset: const Offset(0, AppSpacing.lip),
                  blurRadius: 0,
                ),
              ]
            : null,
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (widget.leading != null) ...<Widget>[
              widget.leading!,
              const SizedBox(width: AppSpacing.s8),
            ] else if (widget.icon != null) ...<Widget>[
              Icon(
                widget.icon,
                size: 20,
                color: _enabled ? colors.text : AppColors.fadedGray,
              ),
              const SizedBox(width: AppSpacing.s8),
            ],
            Flexible(
              child: Text(
                widget.label.toUpperCase(),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.navLabel(
                  color: _enabled ? colors.text : AppColors.fadedGray,
                ).copyWith(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );

    final Widget button = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _enabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: _enabled ? (_) => setState(() => _pressed = false) : null,
      onTapCancel: _enabled ? () => setState(() => _pressed = false) : null,
      onTap: widget.onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.lip),
        child: face,
      ),
    );

    return widget.expand
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}

/// Colores de cara, lip, borde y texto por variante.
class _VariantColors {
  const _VariantColors({
    required this.face,
    required this.lip,
    required this.text,
    this.border,
  });

  final Color face;
  final Color lip;
  final Color text;
  final Color? border;

  static _VariantColors of(DuoButtonVariant variant) {
    switch (variant) {
      case DuoButtonVariant.primary:
        return const _VariantColors(
          face: AppColors.eagerGreen,
          lip: AppColors.eagerGreenLip,
          text: AppColors.paperWhite,
        );
      case DuoButtonVariant.secondary:
        return const _VariantColors(
          face: AppColors.darkSurface,
          lip: AppColors.darkSurfaceLip,
          text: AppColors.sparkBlue,
          border: AppColors.darkBorder,
        );
      case DuoButtonVariant.secondaryError:
        return const _VariantColors(
          face: AppColors.darkSurface,
          lip: AppColors.heartPinkLip,
          text: AppColors.heartPink,
          border: AppColors.heartPink,
        );
      case DuoButtonVariant.error:
        return const _VariantColors(
          face: AppColors.heartPink,
          lip: AppColors.heartPinkLip,
          text: AppColors.paperWhite,
        );
      case DuoButtonVariant.streak:
        return const _VariantColors(
          face: AppColors.streakOrange,
          lip: AppColors.streakOrangeLip,
          text: AppColors.paperWhite,
        );
      case DuoButtonVariant.blue:
        return const _VariantColors(
          face: AppColors.sparkBlue,
          lip: AppColors.sparkBlueLip,
          text: AppColors.paperWhite,
        );
      case DuoButtonVariant.purple:
        return const _VariantColors(
          face: AppColors.superViolet,
          lip: AppColors.superVioletLip,
          text: AppColors.paperWhite,
        );
    }
  }
}
