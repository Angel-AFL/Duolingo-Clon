import 'package:flutter/foundation.dart';

import '../data/mock_data.dart';
import '../data/repositories/profile_repository.dart';
import '../models/profile_info.dart';

/// Estado del perfil del usuario.
class ProfileProvider extends ChangeNotifier {
  ProfileProvider({ProfileRepository? repository})
    : _repository = repository ?? MockProfileRepository();

  final ProfileRepository _repository;

  ProfileInfo _profile = MockData.profile;
  bool _isLoading = false;

  ProfileInfo get profile => _profile;
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    try {
      _profile = await _repository.fetchProfile();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
