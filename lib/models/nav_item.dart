import '../widgets/duo_nav_icon.dart';

/// Item del bottom nav: icono y etiqueta accesible.
class NavItem {
  const NavItem({required this.icon, required this.label});

  final DuoNavIconType icon;

  /// Nombre del destino, usado por lectores de pantalla y tooltips.
  final String label;
}
