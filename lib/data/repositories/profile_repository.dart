import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/profile_info.dart';
import '../mock_data.dart';

/// Acceso al perfil del usuario.
abstract interface class ProfileRepository {
  Future<ProfileInfo> fetchProfile();
}

class SupabaseProfileRepository implements ProfileRepository {
  SupabaseProfileRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<ProfileInfo> fetchProfile() async {
    final String userId = _client.auth.currentUser!.id;
    final Map<String, dynamic> row = await _client
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();
    return ProfileInfo.fromJson(row);
  }
}

class MockProfileRepository implements ProfileRepository {
  @override
  Future<ProfileInfo> fetchProfile() async => MockData.profile;
}
