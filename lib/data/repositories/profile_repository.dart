import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/profile_info.dart';
import '../mock_data.dart';

/// Acceso al perfil del usuario.
abstract interface class ProfileRepository {
  Future<ProfileInfo> fetchProfile();

  /// Sube la imagen al Storage y devuelve su URL publica.
  Future<String> uploadAvatar(Uint8List bytes, String extension);

  /// Persiste la referencia del avatar (URL, asset o `preset:<id>`).
  Future<ProfileInfo> updateAvatarUrl(String avatarUrl);
}

class SupabaseProfileRepository implements ProfileRepository {
  SupabaseProfileRepository(this._client);

  final SupabaseClient _client;

  static const String _bucket = 'avatars';

  @override
  Future<ProfileInfo> fetchProfile() async {
    final User? user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('No hay sesión activa para cargar el perfil.');
    }

    final Map<String, dynamic>? row = await _client
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();
    if (row != null) return ProfileInfo.fromJson(row);

    // Usuario sin fila en `profiles` (p. ej. cuentas previas al esquema):
    // se crea un perfil por defecto para que el modulo siempre tenga datos.
    final ProfileInfo fallback = _defaultProfile(user);
    await _client.from('profiles').upsert(<String, dynamic>{
      'id': user.id,
      ...fallback.toJson(),
    });
    return fallback;
  }

  @override
  Future<String> uploadAvatar(Uint8List bytes, String extension) async {
    final User? user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('No hay sesión activa para subir el avatar.');
    }

    final String ext = extension.toLowerCase().replaceAll('.', '');
    final String path =
        '${user.id}/avatar_${DateTime.now().millisecondsSinceEpoch}.$ext';
    await _client.storage.from(_bucket).uploadBinary(
      path,
      bytes,
      fileOptions: FileOptions(contentType: _contentType(ext), upsert: true),
    );
    return _client.storage.from(_bucket).getPublicUrl(path);
  }

  @override
  Future<ProfileInfo> updateAvatarUrl(String avatarUrl) async {
    final User? user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('No hay sesión activa para actualizar el avatar.');
    }
    await _client
        .from('profiles')
        .update(<String, dynamic>{'avatar_url': avatarUrl})
        .eq('id', user.id);
    return fetchProfile();
  }

  ProfileInfo _defaultProfile(User user) {
    final String prefix = (user.email ?? '').split('@').first;
    final String? metadataName = user.userMetadata?['name'] as String?;
    final int year = DateTime.now().year;
    return ProfileInfo(
      name: (metadataName == null || metadataName.isEmpty)
          ? prefix
          : metadataName,
      handle: '@${prefix.toUpperCase()}',
      joinedYear: year,
      superSince: year,
      courses: 0,
      following: 0,
      followers: 0,
      league: 'Diamante',
      totalExp: 0,
    );
  }

  String _contentType(String ext) {
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'webp':
        return 'image/webp';
      case 'gif':
        return 'image/gif';
      default:
        return 'image/$ext';
    }
  }
}

class MockProfileRepository implements ProfileRepository {
  ProfileInfo _profile = MockData.profile;

  @override
  Future<ProfileInfo> fetchProfile() async => _profile;

  @override
  Future<String> uploadAvatar(Uint8List bytes, String extension) async =>
      'https://mock.local/avatars/mock-user/avatar.$extension';

  @override
  Future<ProfileInfo> updateAvatarUrl(String avatarUrl) async {
    _profile = _profile.copyWith(avatarUrl: avatarUrl);
    return _profile;
  }
}
