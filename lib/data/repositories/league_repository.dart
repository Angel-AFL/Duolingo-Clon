import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/league_entry.dart';
import '../mock_data.dart';

/// Datos completos de la liga del usuario.
class LeagueSnapshot {
  const LeagueSnapshot({
    required this.name,
    required this.daysLeft,
    required this.entries,
  });

  final String name;
  final int daysLeft;
  final List<LeagueEntry> entries;
}

/// Acceso a la liga y su tabla de posiciones.
abstract interface class LeagueRepository {
  Future<LeagueSnapshot> fetchLeague();

  /// Suma EXP al usuario actual de forma atomica.
  Future<void> addExp(int amount);
}

class SupabaseLeagueRepository implements LeagueRepository {
  SupabaseLeagueRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<LeagueSnapshot> fetchLeague() async {
    final String userId = _client.auth.currentUser!.id;
    final Map<String, dynamic>? league = await _client
        .from('leagues')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (league == null) {
      return const LeagueSnapshot(
        name: MockData.leagueName,
        daysLeft: MockData.leagueDaysLeft,
        entries: <LeagueEntry>[],
      );
    }

    final List<Map<String, dynamic>> members = await _client
        .from('league_members')
        .select()
        .eq('league_id', league['id'] as String)
        .order('exp', ascending: false);

    return LeagueSnapshot(
      name: league['name'] as String,
      daysLeft: league['days_left'] as int,
      entries: members.map(LeagueEntry.fromJson).toList(),
    );
  }

  @override
  Future<void> addExp(int amount) async {
    final User? user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('No hay sesión activa para actualizar la liga.');
    }
    await _client.rpc(
      'increment_league_exp',
      params: <String, dynamic>{'amount': amount},
    );
  }
}

class MockLeagueRepository implements LeagueRepository {
  @override
  Future<LeagueSnapshot> fetchLeague() async => const LeagueSnapshot(
    name: MockData.leagueName,
    daysLeft: MockData.leagueDaysLeft,
    entries: MockData.leagueEntries,
  );

  @override
  Future<void> addExp(int amount) async {}
}
