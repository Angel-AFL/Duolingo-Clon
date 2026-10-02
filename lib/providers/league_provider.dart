import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../data/repositories/league_repository.dart';
import '../models/league_entry.dart';
import 'loadable_provider.dart';

/// Estado de la liga: tabla de posiciones y EXP del usuario.
class LeagueProvider extends ChangeNotifier with LoadableProvider {
  LeagueProvider({LeagueRepository? repository})
    : _repository = repository ?? MockLeagueRepository();

  final LeagueRepository _repository;

  List<LeagueEntry> _entries = _sortedByExpDesc(MockData.leagueEntries);
  String _leagueName = MockData.leagueName;
  int _daysLeft = MockData.leagueDaysLeft;

  /// Ordena por EXP descendente (mayor puntaje primero) y recalcula rangos.
  static List<LeagueEntry> _sortedByExpDesc(List<LeagueEntry> entries) {
    final List<LeagueEntry> sorted = List<LeagueEntry>.of(entries)
      ..sort((LeagueEntry a, LeagueEntry b) => b.exp.compareTo(a.exp));
    for (int i = 0; i < sorted.length; i++) {
      sorted[i] = sorted[i].copyWith(rank: i + 1);
    }
    return sorted;
  }

  String get leagueName => _leagueName;
  int get daysLeft => _daysLeft;
  List<LeagueEntry> get entries => List<LeagueEntry>.unmodifiable(_entries);

  LeagueEntry get currentUser =>
      _entries.firstWhere((LeagueEntry e) => e.isCurrentUser);

  Future<void> load() => runLoad(() async {
    final LeagueSnapshot snapshot = await _repository.fetchLeague();
    _leagueName = snapshot.name;
    _daysLeft = snapshot.daysLeft;
    if (snapshot.entries.isNotEmpty) {
      _entries = _sortedByExpDesc(snapshot.entries);
    }
  });

  /// Suma EXP al usuario actual y recalcula posiciones.
  void addExp(int amount) {
    final int index = _entries.indexWhere((LeagueEntry e) => e.isCurrentUser);
    if (index == -1) return;

    _entries[index] = _entries[index].copyWith(
      exp: _entries[index].exp + amount,
    );
    _entries = _sortedByExpDesc(_entries);
    notifyListeners();
    unawaited(_repository.updateCurrentUserExp(currentUser.exp));
  }
}
