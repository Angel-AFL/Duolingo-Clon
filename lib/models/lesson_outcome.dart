/// Resultado de una leccion que alimenta los desafios y el XP del usuario.
class LessonOutcome {
  const LessonOutcome({
    required this.exp,
    required this.accuracy,
    required this.bestStreak,
  });

  /// EXP obtenido en la leccion.
  final int exp;

  /// Precision de la leccion (0.0 a 1.0).
  final double accuracy;

  /// Racha mas larga de respuestas correctas consecutivas.
  final int bestStreak;
}
