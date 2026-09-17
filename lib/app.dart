import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'routes/app_routes.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart';

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
      initialRoute: AppRoutes.login,
      routes: <String, WidgetBuilder>{
        AppRoutes.login: (BuildContext context) => LoginScreen(
              onGetStarted: () =>
                  Navigator.of(context).pushReplacementNamed(AppRoutes.home),
            ),
        AppRoutes.home: (BuildContext context) => const HomeScreen(),
      },
    );
  }
}
