import 'package:flutter/material.dart';

import 'duo_button.dart';

/// CTA primario del skill: relleno Eager Green con relieve 3D de Duolingo.
///
/// Es un wrapper de [DuoButton] para conservar la API historica de la app.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.expand = true,
    this.variant = DuoButtonVariant.primary,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool expand;
  final DuoButtonVariant variant;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return DuoButton(
      label: label,
      onPressed: onPressed,
      expand: expand,
      variant: variant,
      icon: icon,
    );
  }
}
