import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../data/repositories/profile_repository.dart';
import '../models/avatar_preset.dart';
import '../models/profile_info.dart';
import 'loadable_provider.dart';

/// Estado del perfil del usuario.
class ProfileProvider extends ChangeNotifier with LoadableProvider {
  ProfileProvider({ProfileRepository? repository})
    : _repository = repository ?? MockProfileRepository();

  final ProfileRepository _repository;

  ProfileInfo _profile = MockData.profile;
  bool _isUpdatingAvatar = false;

  ProfileInfo get profile => _profile;
  bool get isUpdatingAvatar => _isUpdatingAvatar;

  Future<void> load() => runLoad(() async {
    _profile = await _repository.fetchProfile();
  });

  /// Suma EXP al total del perfil y lo persiste.
  void addExp(int amount) {
    _profile = _profile.copyWith(totalExp: _profile.totalExp + amount);
    notifyListeners();
    unawaited(_repository.addExp(amount));
  }

  /// Sube una imagen elegida por el usuario y actualiza el avatar.
  Future<void> updateAvatarFromBytes(Uint8List bytes, String extension) async {
    await _runAvatarUpdate(() async {
      final String url = await _repository.uploadAvatar(bytes, extension);
      _profile = await _repository.updateAvatarUrl(url);
    });
  }

  /// Selecciona uno de los avatares predefinidos.
  Future<void> selectPresetAvatar(AvatarPreset preset) async {
    await _runAvatarUpdate(() async {
      _profile = await _repository.updateAvatarUrl(preset.storageKey);
    });
  }

  Future<void> _runAvatarUpdate(Future<void> Function() action) async {
    if (_isUpdatingAvatar) return;
    _isUpdatingAvatar = true;
    setError(null);
    try {
      await action();
    } catch (error) {
      setError(error);
    } finally {
      _isUpdatingAvatar = false;
      notifyListeners();
    }
  }
}
