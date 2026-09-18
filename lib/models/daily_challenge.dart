/// Tipo de cofre que se obtiene al completar un reto.
enum ChallengeReward { wood, silver, gold }

/// Reto diario con progreso y meta.
class DailyChallenge {
  const DailyChallenge({
    required this.title,
    required this.progress,
    required this.target,
    required this.reward,
  });

  final String title;
  final int progress;
  final int target;
  final ChallengeReward reward;

  bool get isComplete => progress >= target;

  DailyChallenge copyWith({int? progress}) {
    return DailyChallenge(
      title: title,
      progress: progress ?? this.progress,
      target: target,
      reward: reward,
    );
  }

  factory DailyChallenge.fromJson(Map<String, dynamic> json) {
    return DailyChallenge(
      title: json['title'] as String,
      progress: json['progress'] as int,
      target: json['target'] as int,
      reward: ChallengeReward.values.byName(json['reward'] as String),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'title': title,
    'progress': progress,
    'target': target,
    'reward': reward.name,
  };
}
