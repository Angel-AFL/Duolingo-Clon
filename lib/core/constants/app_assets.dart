/// Recursos de la app.
///
/// Las imágenes viven en `assets/images/` (registrada en `pubspec.yaml`).
/// Usa [image] para referenciar cualquier archivo de esa carpeta sin
/// repetir la ruta base.
abstract final class AppAssets {
  static const String _images = 'assets/images';

  /// `true` cuando `assets/images/duo.png` existe; si no, `DuoMascot`
  /// cae al placeholder dibujado.
  static const bool hasMascotAsset = true;
  static const String duoMascot = '$_images/duo.png';

  /// Ruta de una imagen dentro de `assets/images/`.
  static String image(String name) => '$_images/$name';
}
