import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../data/repositories/user_stats_repository.dart';
import '../models/user_stats.dart';
import 'loadable_provider.dart';

/// Estado del usuario (stats de la barra superior y corazones).
class UserStatsProvider extends ChangeNotifier with LoadableProvider {
  UserStatsProvider({UserStatsRepository? repository})
    : _repository = repository ?? MockUserStatsRepository();

  final UserStatsRepository _repository;

  /// Corazones maximos de una sesion.
  static const int maxHearts = 5;

  UserStats _stats = MockData.userStats;
  int _hearts = maxHearts;

  UserStats get stats => _stats;

  /// Corazones actuales (ignorado si el usuario es Súper).
  int get hearts => _hearts;

  /// Si es `true`, los corazones son infinitos.
  bool get hasUnlimitedHearts => _stats.hasUnlimitedHearts;

  /// Sin corazones y sin Súper: la leccion queda bloqueada.
  bool get isOutOfHearts => !hasUnlimitedHearts && _hearts <= 0;

  /// Carga las stats desde el repositorio (Supabase o mock).
  Future<void> load() => runLoad(() async {
    _stats = await _repository.fetchStats();
    _hearts = maxHearts;
  });

  /// Resta un corazon si el usuario no es Súper ni esta a cero.
  void consumeHeart() {
    if (hasUnlimitedHearts || _hearts <= 0) return;
    _hearts--;
    notifyListeners();
  }

  /// Rellena los corazones al maximo.
  void refillHearts() {
    if (_hearts == maxHearts) return;
    _hearts = maxHearts;
    notifyListeners();
  }
}
