import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../data/repositories/user_stats_repository.dart';
import '../models/user_stats.dart';
import 'loadable_provider.dart';

/// Estado del usuario (stats de la barra superior).
class UserStatsProvider extends ChangeNotifier with LoadableProvider {
  UserStatsProvider({UserStatsRepository? repository})
    : _repository = repository ?? MockUserStatsRepository();

  final UserStatsRepository _repository;

  UserStats _stats = MockData.userStats;

  UserStats get stats => _stats;

  /// Carga las stats desde el repositorio (Supabase o mock).
  Future<void> load() => runLoad(() async {
    _stats = await _repository.fetchStats();
  });

  void addGems(int amount) {
    _stats = UserStats(
      courseFlag: _stats.courseFlag,
      courseCount: _stats.courseCount,
      streakDays: _stats.streakDays,
      gems: _stats.gems + amount,
      hasUnlimitedHearts: _stats.hasUnlimitedHearts,
    );
    notifyListeners();
    unawaited(_repository.updateStats(_stats));
  }
}
