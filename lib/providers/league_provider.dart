import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../models/league_entry.dart';

/// Estado de la liga: tabla de posiciones y EXP del usuario.
class LeagueProvider extends ChangeNotifier {
  final List<LeagueEntry> _entries = List<LeagueEntry>.of(
    MockData.leagueEntries,
  );

  String get leagueName => MockData.leagueName;
  int get daysLeft => MockData.leagueDaysLeft;
  List<LeagueEntry> get entries => List<LeagueEntry>.unmodifiable(_entries);

  LeagueEntry get currentUser =>
      _entries.firstWhere((LeagueEntry e) => e.isCurrentUser);

  /// Suma EXP al usuario actual y recalcula posiciones.
  void addExp(int amount) {
    final int index = _entries.indexWhere((LeagueEntry e) => e.isCurrentUser);
    if (index == -1) return;

    _entries[index] = _entries[index].copyWith(
      exp: _entries[index].exp + amount,
    );
    _entries.sort((LeagueEntry a, LeagueEntry b) => b.exp.compareTo(a.exp));
    for (int i = 0; i < _entries.length; i++) {
      _entries[i] = _entries[i].copyWith(rank: i + 1);
    }
    notifyListeners();
  }
}
