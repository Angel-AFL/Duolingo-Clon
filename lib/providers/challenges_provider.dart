import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../data/repositories/challenges_repository.dart';
import '../models/daily_challenge.dart';
import '../models/lesson_outcome.dart';
import 'loadable_provider.dart';

/// Estado de los desafios: puntos del mes y retos del dia.
class ChallengesProvider extends ChangeNotifier with LoadableProvider {
  ChallengesProvider({ChallengesRepository? repository})
    : _repository = repository ?? MockChallengesRepository();

  final ChallengesRepository _repository;

  /// Racha minima de aciertos para avanzar un reto de tipo `streak`.
  static const int _streakThreshold = 3;

  /// Precision minima para avanzar un reto de tipo `accuracy`.
  static const double _accuracyThreshold = 0.9;

  int _points = MockData.challengePoints;
  int _pointsTarget = MockData.challengePointsTarget;
  bool _cheered = false;
  bool _gifted = false;
  List<DailyChallenge> _challenges = List<DailyChallenge>.of(
    MockData.dailyChallenges,
  );

  int get points => _points;
  int get pointsTarget => _pointsTarget;
  bool get cheered => _cheered;
  bool get gifted => _gifted;
  List<DailyChallenge> get challenges =>
      List<DailyChallenge>.unmodifiable(_challenges);

  Future<void> load() => runLoad(() async {
    final ChallengeSnapshot snapshot = await _repository.fetchChallenges();
    _points = snapshot.points;
    _pointsTarget = snapshot.pointsTarget;
    if (snapshot.challenges.isNotEmpty) _challenges = snapshot.challenges;
  });

  /// Registra una leccion: suma su EXP al desafio del mes y avanza cada reto
  /// segun su metrica real (EXP ganado, racha de aciertos o precision).
  void recordLesson(LessonOutcome outcome) {
    _points = (_points + outcome.exp).clamp(0, _pointsTarget);
    for (int i = 0; i < _challenges.length; i++) {
      final DailyChallenge challenge = _challenges[i];
      if (challenge.isComplete) continue;

      final int increment;
      switch (challenge.metric) {
        case ChallengeMetric.exp:
          increment = outcome.exp;
        case ChallengeMetric.streak:
          increment = outcome.bestStreak >= _streakThreshold ? 1 : 0;
        case ChallengeMetric.accuracy:
          increment = outcome.accuracy >= _accuracyThreshold ? 1 : 0;
      }
      if (increment <= 0) continue;

      _challenges[i] = challenge.copyWith(
        progress: (challenge.progress + increment).clamp(0, challenge.target),
      );
    }
    notifyListeners();
    unawaited(_repository.saveChallenges(_points, _challenges));
  }

  void giveCheer() {
    if (_cheered) return;
    _cheered = true;
    notifyListeners();
  }

  void giveGift() {
    if (_gifted) return;
    _gifted = true;
    notifyListeners();
  }
}
