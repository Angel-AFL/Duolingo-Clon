import 'package:flutter/material.dart';

/// Item del bottom nav: icono, color de acento y etiqueta accesible.
class NavItem {
  const NavItem({
    required this.icon,
    required this.color,
    required this.label,
  });

  final IconData icon;
  final Color color;

  /// Nombre del destino, usado por lectores de pantalla y tooltips.
  final String label;
}
