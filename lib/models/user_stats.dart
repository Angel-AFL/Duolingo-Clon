/// Estadisticas del usuario que alimentan la barra superior.
class UserStats {
  const UserStats({
    required this.courseFlag,
    required this.courseCount,
    required this.streakDays,
    required this.gems,
    required this.hasUnlimitedHearts,
  });

  /// Bandera (emoji) del curso activo.
  final String courseFlag;

  /// Numero mostrado junto a la bandera.
  final int courseCount;

  /// Dias de racha actuales.
  final int streakDays;

  /// Gemas acumuladas.
  final int gems;

  /// Si es `true`, los corazones son infinitos (Súper).
  final bool hasUnlimitedHearts;
}
