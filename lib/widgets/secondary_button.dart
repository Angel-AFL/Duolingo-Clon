import 'package:flutter/material.dart';

import 'duo_button.dart';

/// CTA secundario del skill: cara oscura, texto Spark Blue y relieve 3D.
///
/// Es un wrapper de [DuoButton] para conservar la API historica de la app.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.expand = true,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool expand;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return DuoButton(
      label: label,
      onPressed: onPressed,
      expand: expand,
      variant: DuoButtonVariant.secondary,
      icon: icon,
    );
  }
}
