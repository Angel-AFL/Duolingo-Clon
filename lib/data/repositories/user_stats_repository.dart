import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/user_stats.dart';
import '../mock_data.dart';

/// Acceso a las estadisticas del usuario.
abstract interface class UserStatsRepository {
  Future<UserStats> fetchStats();

  Future<void> updateStats(UserStats stats);
}

class SupabaseUserStatsRepository implements UserStatsRepository {
  SupabaseUserStatsRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<UserStats> fetchStats() async {
    final String userId = _client.auth.currentUser!.id;
    final Map<String, dynamic> row = await _client
        .from('user_stats')
        .select()
        .eq('user_id', userId)
        .single();
    return UserStats.fromJson(row);
  }

  @override
  Future<void> updateStats(UserStats stats) async {
    final String userId = _client.auth.currentUser!.id;
    await _client
        .from('user_stats')
        .update(stats.toJson())
        .eq('user_id', userId);
  }
}

class MockUserStatsRepository implements UserStatsRepository {
  UserStats _stats = MockData.userStats;

  @override
  Future<UserStats> fetchStats() async => _stats;

  @override
  Future<void> updateStats(UserStats stats) async => _stats = stats;
}
