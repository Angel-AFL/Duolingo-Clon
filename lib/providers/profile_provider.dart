import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../data/repositories/profile_repository.dart';
import '../models/avatar_preset.dart';
import '../models/profile_info.dart';

/// Estado del perfil del usuario.
class ProfileProvider extends ChangeNotifier {
  ProfileProvider({ProfileRepository? repository})
    : _repository = repository ?? MockProfileRepository();

  final ProfileRepository _repository;

  ProfileInfo _profile = MockData.profile;
  bool _isLoading = false;
  bool _hasLoaded = false;
  bool _isUpdatingAvatar = false;
  String? _error;

  ProfileInfo get profile => _profile;
  bool get isLoading => _isLoading;
  bool get hasLoaded => _hasLoaded;
  bool get isUpdatingAvatar => _isUpdatingAvatar;
  bool get hasError => _error != null;
  String? get error => _error;

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _profile = await _repository.fetchProfile();
      _hasLoaded = true;
    } catch (error) {
      _error = error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Sube una imagen elegida por el usuario y actualiza el avatar.
  Future<void> updateAvatarFromBytes(
    Uint8List bytes,
    String extension,
  ) async {
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
    _error = null;
    notifyListeners();
    try {
      await action();
    } catch (error) {
      _error = error.toString();
    } finally {
      _isUpdatingAvatar = false;
      notifyListeners();
    }
  }
}
