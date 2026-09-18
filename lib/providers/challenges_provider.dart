import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../models/daily_challenge.dart';

/// Estado de los desafios: puntos del mes y retos del dia.
class ChallengesProvider extends ChangeNotifier {
  int _points = MockData.challengePoints;
  bool _cheered = false;
  bool _gifted = false;
  final List<DailyChallenge> _challenges = List<DailyChallenge>.of(
    MockData.dailyChallenges,
  );

  int get points => _points;
  int get pointsTarget => MockData.challengePointsTarget;
  bool get cheered => _cheered;
  bool get gifted => _gifted;
  List<DailyChallenge> get challenges =>
      List<DailyChallenge>.unmodifiable(_challenges);

  /// Suma puntos de desafio (sin pasar de la meta) y avanza los retos.
  void addPoints(int amount) {
    _points = (_points + amount).clamp(0, pointsTarget);
    for (int i = 0; i < _challenges.length; i++) {
      final DailyChallenge challenge = _challenges[i];
      if (!challenge.isComplete) {
        _challenges[i] = challenge.copyWith(
          progress: (challenge.progress + 1).clamp(0, challenge.target),
        );
      }
    }
    notifyListeners();
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
