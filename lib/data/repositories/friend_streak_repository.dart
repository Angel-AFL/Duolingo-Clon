import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/friend_streak.dart';
import '../mock_data.dart';

/// Acceso a las rachas compartidas con amigos.
abstract interface class FriendStreakRepository {
  Future<List<FriendStreak>> fetchFriendStreaks();
}

class SupabaseFriendStreakRepository implements FriendStreakRepository {
  SupabaseFriendStreakRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<FriendStreak>> fetchFriendStreaks() async {
    final String userId = _client.auth.currentUser!.id;
    final List<Map<String, dynamic>> rows = await _client
        .from('friend_streaks')
        .select()
        .eq('user_id', userId)
        .order('position');
    return rows.map(FriendStreak.fromJson).toList();
  }
}

class MockFriendStreakRepository implements FriendStreakRepository {
  @override
  Future<List<FriendStreak>> fetchFriendStreaks() async =>
      MockData.friendStreaks;
}
