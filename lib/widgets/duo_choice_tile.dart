import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';

/// Estado visual de una ficha seleccionable.
enum DuoChoiceState { idle, selected, correct, wrong }

/// Ficha con relieve 3D tipo tecla, usada por los ejercicios de la leccion.
class DuoChoiceTile extends StatefulWidget {
  const DuoChoiceTile({
    super.key,
    required this.label,
    this.state = DuoChoiceState.idle,
    this.onTap,
    this.dimmed = false,
    this.trailing,
    this.centerLabel = false,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.s16,
      vertical: AppSpacing.s16,
    ),
  });

  final String label;
  final DuoChoiceState state;
  final VoidCallback? onTap;

  /// Ficha ya usada (p. ej. palabra consumida del banco): se apaga.
  final bool dimmed;

  final Widget? trailing;

  /// Centra la etiqueta (fichas de emparejar).
  final bool centerLabel;

  /// Padding interno; las fichas compactas (banco de palabras) lo reducen.
  final EdgeInsetsGeometry contentPadding;

  @override
  State<DuoChoiceTile> createState() => _DuoChoiceTileState();
}

class _DuoChoiceTileState extends State<DuoChoiceTile> {
  bool _pressed = false;

  bool get _enabled => widget.onTap != null && !widget.dimmed;

  @override
  Widget build(BuildContext context) {
    final _ChoiceColors colors = _ChoiceColors.of(widget.state, widget.dimmed);
    final bool sunk = _pressed && _enabled;

    final Widget face = AnimatedContainer(
      duration: const Duration(milliseconds: 90),
      curve: Curves.easeOut,
      transform: Matrix4.translationValues(0, sunk ? AppSpacing.lip : 0, 0),
      padding: widget.contentPadding,
      decoration: BoxDecoration(
        color: colors.face,
        borderRadius: BorderRadius.circular(AppRadius.button),
        border: Border.all(color: colors.border, width: 2),
        boxShadow: sunk || widget.dimmed
            ? null
            : <BoxShadow>[
                BoxShadow(
                  color: colors.lip,
                  offset: const Offset(0, AppSpacing.lip),
                  blurRadius: 0,
                ),
              ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              widget.label,
              textAlign: widget.centerLabel
                  ? TextAlign.center
                  : TextAlign.start,
              style: AppTypography.body(
                color: colors.text,
              ).copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          if (widget.trailing != null) widget.trailing!,
        ],
      ),
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _enabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: _enabled ? (_) => setState(() => _pressed = false) : null,
      onTapCancel: _enabled ? () => setState(() => _pressed = false) : null,
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.lip),
        child: face,
      ),
    );
  }
}

/// Colores de cara, borde, lip y texto por estado.
class _ChoiceColors {
  const _ChoiceColors({
    required this.face,
    required this.border,
    required this.lip,
    required this.text,
  });

  final Color face;
  final Color border;
  final Color lip;
  final Color text;

  static _ChoiceColors of(DuoChoiceState state, bool dimmed) {
    if (dimmed) {
      return _ChoiceColors(
        face: Colors.transparent,
        border: AppColors.darkSurface,
        lip: Colors.transparent,
        text: AppColors.pathLockedText,
      );
    }
    switch (state) {
      case DuoChoiceState.idle:
        return const _ChoiceColors(
          face: AppColors.darkSurface,
          border: AppColors.darkBorder,
          lip: AppColors.darkSurfaceLip,
          text: AppColors.paperWhite,
        );
      case DuoChoiceState.selected:
        return _ChoiceColors(
          face: Color.alphaBlend(
            AppColors.sparkBlue.withValues(alpha: 0.18),
            AppColors.darkSurface,
          ),
          border: AppColors.sparkBlue,
          lip: AppColors.sparkBlueLip,
          text: AppColors.sparkBlue,
        );
      case DuoChoiceState.correct:
        return _ChoiceColors(
          face: Color.alphaBlend(
            AppColors.eagerGreen.withValues(alpha: 0.22),
            AppColors.darkSurface,
          ),
          border: AppColors.eagerGreen,
          lip: AppColors.eagerGreenLip,
          text: AppColors.eagerGreen,
        );
      case DuoChoiceState.wrong:
        return _ChoiceColors(
          face: Color.alphaBlend(
            AppColors.heartPink.withValues(alpha: 0.22),
            AppColors.darkSurface,
          ),
          border: AppColors.heartPink,
          lip: AppColors.heartPinkLip,
          text: AppColors.heartPink,
        );
    }
  }
}
