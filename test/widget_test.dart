import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:duolingo_clon/app.dart';
import 'package:duolingo_clon/providers/auth_provider.dart';
import 'package:duolingo_clon/providers/challenges_provider.dart';
import 'package:duolingo_clon/providers/league_provider.dart';
import 'package:duolingo_clon/providers/learning_path_provider.dart';
import 'package:duolingo_clon/providers/profile_provider.dart';
import 'package:duolingo_clon/providers/streak_provider.dart';
import 'package:duolingo_clon/providers/user_stats_provider.dart';
import 'package:duolingo_clon/routes/app_routes.dart';
import 'package:duolingo_clon/screens/challenges/challenges_screen.dart';
import 'package:duolingo_clon/screens/league/league_screen.dart';
import 'package:duolingo_clon/screens/profile/profile_screen.dart';
import 'package:duolingo_clon/screens/profile/widgets/friend_streak_item.dart';
import 'package:duolingo_clon/screens/streak/streak_screen.dart';
import 'package:duolingo_clon/widgets/app_bottom_nav.dart';

List<ChangeNotifierProvider> _providers() => <ChangeNotifierProvider>[
  ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
  ChangeNotifierProvider<UserStatsProvider>(create: (_) => UserStatsProvider()),
  ChangeNotifierProvider<LearningPathProvider>(
    create: (_) => LearningPathProvider(),
  ),
  ChangeNotifierProvider<ChallengesProvider>(
    create: (_) => ChallengesProvider(),
  ),
  ChangeNotifierProvider<LeagueProvider>(create: (_) => LeagueProvider()),
  ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),
  ChangeNotifierProvider<StreakProvider>(create: (_) => StreakProvider()),
];

Widget _app() =>
    MultiProvider(providers: _providers(), child: const DuolingoApp());

Widget _screen(Widget child) => MultiProvider(
  providers: _providers(),
  child: MaterialApp(
    themeMode: ThemeMode.dark,
    darkTheme: ThemeData.dark(),
    routes: <String, WidgetBuilder>{
      AppRoutes.streak: (BuildContext context) => const StreakScreen(),
    },
    home: Scaffold(body: child),
  ),
);

Future<void> _login(WidgetTester tester) async {
  await tester.enterText(find.byType(TextField).at(0), 'test@test.com');
  await tester.enterText(find.byType(TextField).at(1), 'secret123');
  await tester.tap(find.text('INICIAR SESIÓN'));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('login autentica y navega al home', (WidgetTester tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();

    expect(find.text('duolingo'), findsOneWidget);
    expect(find.text('INICIAR SESIÓN'), findsOneWidget);

    await _login(tester);

    expect(find.text('Parejas: Expresa tus sentimientos'), findsOneWidget);
  });

  testWidgets('el bottom nav cambia de pestana', (WidgetTester tester) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    await _login(tester);

    AppBottomNav nav() =>
        tester.widget<AppBottomNav>(find.byType(AppBottomNav));
    expect(nav().selectedIndex, 0);

    await tester.tap(
      find.descendant(
        of: find.byType(AppBottomNav),
        matching: find.byIcon(Icons.emoji_events_rounded),
      ),
    );
    await tester.pumpAndSettle();
    expect(nav().selectedIndex, 4);

    await tester.tap(
      find.descendant(
        of: find.byType(AppBottomNav),
        matching: find.byIcon(Icons.more_horiz_rounded),
      ),
    );
    await tester.pumpAndSettle();
    expect(nav().selectedIndex, 5);
  });

  testWidgets('liga muestra la tabla de posiciones', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_screen(const LeagueScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Final'), findsOneWidget);
    expect(find.text('Angel AFL'), findsOneWidget);
    expect(find.text('928 EXP'), findsOneWidget);
  });

  testWidgets('desafios muestra los retos del dia', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_screen(const ChallengesScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Desafío de septiembre'), findsOneWidget);
    expect(find.text('DESAFÍOS DEL DÍA'), findsOneWidget);
    expect(find.text('Gana 50 EXP'), findsOneWidget);
  });

  testWidgets('perfil abre la pantalla de rachas', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_screen(const ProfileScreen()));
    await tester.pumpAndSettle();

    expect(find.text('RACHAS ENTRE AMIGOS'), findsOneWidget);

    await tester.tap(find.byType(FriendStreakItem).first);
    await tester.pumpAndSettle();

    expect(find.text('Días de racha'), findsOneWidget);
    expect(find.text('PERSONAL'), findsOneWidget);
  });

  testWidgets('el perchero cambia el avatar por un preset', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(_screen(const ProfileScreen()));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.emoji_nature_rounded), findsNothing);

    await tester.tap(find.byIcon(Icons.checkroom_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Elige tu foto'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.emoji_nature_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Elige tu foto'), findsNothing);
    expect(find.byIcon(Icons.emoji_nature_rounded), findsOneWidget);
  });
}
