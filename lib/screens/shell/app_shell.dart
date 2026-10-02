import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';
import '../../models/nav_item.dart';
import '../../widgets/duo_nav_icon.dart';
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
/// El nav tiene las 4 pestanas implementadas (Home, Desafios, Liga, Perfil).
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

  List<NavItem> _navItems(AppLocalizations l10n) => <NavItem>[
    NavItem(icon: DuoNavIconType.home, label: l10n.navHome),
    NavItem(icon: DuoNavIconType.challenges, label: l10n.navChallenges),
    NavItem(icon: DuoNavIconType.league, label: l10n.navLeague),
    NavItem(icon: DuoNavIconType.profile, label: l10n.navProfile),
  ];

  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    ChallengesScreen(),
    LeagueScreen(),
    ProfileScreen(),
  ];

  void _onNavTap(int navIndex) {
    setState(() => _selectedIndex = navIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: AppBottomNav(
        items: _navItems(AppLocalizations.of(context)),
        selectedIndex: _selectedIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
