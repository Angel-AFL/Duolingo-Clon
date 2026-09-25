import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../models/nav_item.dart';
import '../../providers/challenges_provider.dart';
import '../../providers/league_provider.dart';
import '../../providers/learning_path_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/streak_provider.dart';
import '../../providers/user_stats_provider.dart';
import '../../widgets/app_bottom_nav.dart';
import '../challenges/challenges_screen.dart';
import '../home/home_screen.dart';
import '../league/league_screen.dart';
import '../profile/profile_screen.dart';

/// Contenedor de las pestanas principales con bottom nav compartido.
///
/// Mapea los 6 items del nav a las 4 pantallas implementadas; los items sin
/// boceto (indices 2 y 3) quedan deshabilitados.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadProviders());
  }

  /// Carga los datos desde Supabase (o mock) una vez que hay sesion activa.
  ///
  /// `AppShell` solo se construye autenticado, asi que aqui es donde los
  /// providers deben consultar la base de datos, no en `main.dart`.
  void _loadProviders() {
    if (!mounted) return;
    context.read<UserStatsProvider>().load();
    context.read<LearningPathProvider>().load();
    context.read<ChallengesProvider>().load();
    context.read<LeagueProvider>().load();
    context.read<ProfileProvider>().load();
    context.read<StreakProvider>().load();
  }

  static const List<NavItem> _navItems = <NavItem>[
    NavItem(icon: Icons.home_rounded, color: AppColors.streakOrange),
    NavItem(icon: Icons.fitness_center_rounded, color: AppColors.streakOrange),
    NavItem(icon: Icons.diamond_rounded, color: AppColors.gemBlue),
    NavItem(icon: Icons.favorite_rounded, color: AppColors.heartPink),
    NavItem(icon: Icons.emoji_events_rounded, color: AppColors.sparkBlue),
    NavItem(icon: Icons.more_horiz_rounded, color: AppColors.leaguePurple),
  ];

  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    ChallengesScreen(),
    LeagueScreen(),
    ProfileScreen(),
  ];

  /// Indice de pantalla para un item del nav, o `null` si no tiene pantalla.
  int? _screenIndexFor(int navIndex) {
    switch (navIndex) {
      case 0:
        return 0;
      case 1:
        return 1;
      case 4:
        return 2;
      case 5:
        return 3;
      default:
        return null;
    }
  }

  void _onNavTap(int navIndex) {
    if (_screenIndexFor(navIndex) == null) return;
    setState(() => _selectedIndex = navIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: IndexedStack(
        index: _screenIndexFor(_selectedIndex) ?? 0,
        children: _screens,
      ),
      bottomNavigationBar: AppBottomNav(
        items: _navItems,
        selectedIndex: _selectedIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
