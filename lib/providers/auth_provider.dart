import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/repositories/auth_repository.dart';

/// Estado de autenticacion del usuario.
class AuthProvider extends ChangeNotifier {
  AuthProvider({AuthRepository? repository})
    : _repository = repository ?? MockAuthRepository() {
    _userId = _repository.currentUserId;
    _subscription = _repository.authStateChanges.listen(
      (String? userId) {
        _userId = userId;
        notifyListeners();
      },
      onError: (Object error) => _error = error.toString(),
    );
  }

  final AuthRepository _repository;
  late final StreamSubscription<String?> _subscription;

  String? _userId;
  String? _error;
  bool _isSubmitting = false;

  String? get userId => _userId;
  String? get error => _error;
  bool get isSubmitting => _isSubmitting;
  bool get isAuthenticated => _userId != null;

  Future<bool> signIn({required String email, required String password}) {
    return _run(() => _repository.signIn(email: email, password: password));
  }

  Future<bool> signUp({
    required String email,
    required String password,
    String? name,
  }) {
    return _run(
      () => _repository.signUp(email: email, password: password, name: name),
    );
  }

  Future<void> signOut() async {
    await _repository.signOut();
    _userId = null;
    notifyListeners();
  }

  void clearError() {
    if (_error == null) return;
    _error = null;
    notifyListeners();
  }

  Future<bool> _run(Future<void> Function() action) async {
    _isSubmitting = true;
    _error = null;
    notifyListeners();
    try {
      await action();
      return true;
    } catch (error) {
      _error = error.toString();
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
