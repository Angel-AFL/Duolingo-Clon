/// Escala de espaciado y radios del sistema de diseño Duolingo.
///
/// Base unit: 4px. Radios siempre 12px (links, botones, nav-items).
abstract final class AppSpacing {
  static const double unit = 4;
  static const double s8 = 8;
  static const double s12 = 12;
  static const double s16 = 16;
  static const double s24 = 24;
  static const double s32 = 32;
  static const double s40 = 40;
  static const double s48 = 48;
  static const double s64 = 64;
  static const double s80 = 80;
  static const double s96 = 96;

  /// Ancho maximo de contenido.
  static const double pageMaxWidth = 1200;

  /// Padding horizontal de pantalla en movil.
  static const double screenPadding = 16;

  /// Separacion entre elementos.
  static const double elementGap = 12;
}

/// Radios del skill: todo usa esquinas redondeadas de 12px.
abstract final class AppRadius {
  static const double standard = 12;
  static const double pill = 100;
}
