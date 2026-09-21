import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../data/repositories/challenges_repository.dart';
import '../models/daily_challenge.dart';

/// Estado de los desafios: puntos del mes y retos del dia.
class ChallengesProvider extends ChangeNotifier {
  ChallengesProvider({ChallengesRepository? repository})
    : _repository = repository ?? MockChallengesRepository();

  final ChallengesRepository _repository;

  int _points = MockData.challengePoints;
  int _pointsTarget = MockData.challengePointsTarget;
  bool _cheered = false;
  bool _gifted = false;
  bool _isLoading = false;
  List<DailyChallenge> _challenges = List<DailyChallenge>.of(
    MockData.dailyChallenges,
  );

  int get points => _points;
  int get pointsTarget => _pointsTarget;
  bool get cheered => _cheered;
  bool get gifted => _gifted;
  bool get isLoading => _isLoading;
  List<DailyChallenge> get challenges =>
      List<DailyChallenge>.unmodifiable(_challenges);

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    try {
      final ChallengeSnapshot snapshot = await _repository.fetchChallenges();
      _points = snapshot.points;
      _pointsTarget = snapshot.pointsTarget;
      if (snapshot.challenges.isNotEmpty) _challenges = snapshot.challenges;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Suma puntos de desafio (sin pasar de la meta) y avanza los retos.
  void addPoints(int amount) {
    _points = (_points + amount).clamp(0, _pointsTarget);
    for (int i = 0; i < _challenges.length; i++) {
      final DailyChallenge challenge = _challenges[i];
      if (!challenge.isComplete) {
        _challenges[i] = challenge.copyWith(
          progress: (challenge.progress + 1).clamp(0, challenge.target),
        );
      }
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
