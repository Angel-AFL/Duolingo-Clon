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

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      courseFlag: json['course_flag'] as String,
      courseCount: json['course_count'] as int,
      streakDays: json['streak_days'] as int,
      gems: json['gems'] as int,
      hasUnlimitedHearts: json['has_unlimited_hearts'] as bool,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'course_flag': courseFlag,
    'course_count': courseCount,
    'streak_days': streakDays,
    'gems': gems,
    'has_unlimited_hearts': hasUnlimitedHearts,
  };
}
