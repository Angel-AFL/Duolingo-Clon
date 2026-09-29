/// Tipo de cofre que se obtiene al completar un reto.
enum ChallengeReward { wood, silver, gold }

/// Metrica que hace avanzar un reto diario.
enum ChallengeMetric {
  /// Suma el EXP real obtenido en la leccion.
  exp,

  /// Cuenta lecciones con una racha de aciertos consecutivos.
  streak,

  /// Cuenta lecciones con una precision minima.
  accuracy,
}

/// Reto diario con progreso, meta y metrica.
class DailyChallenge {
  const DailyChallenge({
    required this.title,
    required this.progress,
    required this.target,
    required this.reward,
    this.metric = ChallengeMetric.exp,
  });

  final String title;
  final int progress;
  final int target;
  final ChallengeReward reward;
  final ChallengeMetric metric;

  bool get isComplete => progress >= target;

  DailyChallenge copyWith({int? progress}) {
    return DailyChallenge(
      title: title,
      progress: progress ?? this.progress,
      target: target,
      reward: reward,
      metric: metric,
    );
  }

  factory DailyChallenge.fromJson(Map<String, dynamic> json) {
    return DailyChallenge(
      title: json['title'] as String,
      progress: json['progress'] as int,
      target: json['target'] as int,
      reward: ChallengeReward.values.byName(json['reward'] as String),
      metric: ChallengeMetric.values.byName(
        (json['metric'] as String?) ?? ChallengeMetric.exp.name,
      ),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'title': title,
    'progress': progress,
    'target': target,
    'reward': reward.name,
    'metric': metric.name,
  };
}
