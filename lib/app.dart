import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'routes/app_routes.dart';
import 'screens/login/login_screen.dart';
import 'screens/shell/app_shell.dart';
import 'screens/streak/streak_screen.dart';

/// Raiz de la app: temas y rutas.
class DuolingoApp extends StatelessWidget {
  const DuolingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Duolingo Clone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: const _AuthGate(),
      routes: <String, WidgetBuilder>{
        AppRoutes.streak: (BuildContext context) => const StreakScreen(),
      },
    );
  }
}

/// Muestra el login o el shell segun el estado de autenticacion.
class _AuthGate extends StatelessWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    final bool isAuthenticated = context.select<AuthProvider, bool>(
      (AuthProvider auth) => auth.isAuthenticated,
    );
    return isAuthenticated ? const AppShell() : const LoginScreen();
  }
}
