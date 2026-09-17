import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../models/user_stats.dart';

/// Estado del usuario (stats de la barra superior).
class UserStatsProvider extends ChangeNotifier {
  UserStats _stats = MockData.userStats;

  UserStats get stats => _stats;

  void addGems(int amount) {
    _stats = UserStats(
      courseFlag: _stats.courseFlag,
      courseCount: _stats.courseCount,
      streakDays: _stats.streakDays,
      gems: _stats.gems + amount,
      hasUnlimitedHearts: _stats.hasUnlimitedHearts,
    );
    notifyListeners();
  }
}
