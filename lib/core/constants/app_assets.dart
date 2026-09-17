/// Recursos de la app.
///
/// Aun no se incluyen los PNGs de la mascota en el repo. Mientras
/// `hasMascotAsset` sea `false`, los widgets usan un placeholder dibujado.
/// Al agregar `assets/images/duo.png`, registrarlo en `pubspec.yaml` y
/// cambiar la bandera a `true`.
abstract final class AppAssets {
  static const bool hasMascotAsset = false;
  static const String duoMascot = 'assets/images/duo.png';
}
