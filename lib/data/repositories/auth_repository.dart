import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

/// Acceso a la autenticacion. Abstrae Supabase para poder usar mocks en tests.
abstract interface class AuthRepository {
  /// Emite el id del usuario actual (o `null` al cerrar sesion).
  Stream<String?> get authStateChanges;

  String? get currentUserId;

  Future<void> signIn({required String email, required String password});

  Future<void> signUp({
    required String email,
    required String password,
    String? name,
  });

  Future<void> signOut();
}

/// Implementacion real sobre `supabase_flutter`.
class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._auth);

  final GoTrueClient _auth;

  @override
  Stream<String?> get authStateChanges =>
      _auth.onAuthStateChange.map((AuthState state) => state.session?.user.id);

  @override
  String? get currentUserId => _auth.currentUser?.id;

  @override
  Future<void> signIn({required String email, required String password}) {
    return _auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    String? name,
  }) {
    return _auth.signUp(
      email: email,
      password: password,
      data: <String, dynamic>{if (name != null && name.isNotEmpty) 'name': name},
    );
  }

  @override
  Future<void> signOut() => _auth.signOut();
}

/// Implementacion en memoria para tests y modo offline.
class MockAuthRepository implements AuthRepository {
  final StreamController<String?> _controller =
      StreamController<String?>.broadcast();
  String? _userId;

  @override
  Stream<String?> get authStateChanges => _controller.stream;

  @override
  String? get currentUserId => _userId;

  @override
  Future<void> signIn({required String email, required String password}) async {
    _userId = 'mock-user';
    _controller.add(_userId);
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    _userId = 'mock-user';
    _controller.add(_userId);
  }

  @override
  Future<void> signOut() async {
    _userId = null;
    _controller.add(null);
  }
}
