import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/user_stats.dart';
import '../mock_data.dart';

/// Acceso a las estadisticas del usuario.
abstract interface class UserStatsRepository {
  Future<UserStats> fetchStats();
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
}

class MockUserStatsRepository implements UserStatsRepository {
  final UserStats _stats = MockData.userStats;

  @override
  Future<UserStats> fetchStats() async => _stats;
}
