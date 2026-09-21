import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/streak_calendar.dart';
import '../mock_data.dart';

/// Acceso al calendario de racha del usuario.
abstract interface class StreakRepository {
  Future<StreakCalendar> fetchCalendar();
}

class SupabaseStreakRepository implements StreakRepository {
  SupabaseStreakRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<StreakCalendar> fetchCalendar() async {
    final String userId = _client.auth.currentUser!.id;
    final Map<String, dynamic> row = await _client
        .from('streak_calendar')
        .select()
        .eq('user_id', userId)
        .single();
    return StreakCalendar.fromJson(row);
  }
}

class MockStreakRepository implements StreakRepository {
  @override
  Future<StreakCalendar> fetchCalendar() async => MockData.streakCalendar;
}
