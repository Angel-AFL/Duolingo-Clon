import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:duolingo_clon/app.dart';
import 'package:duolingo_clon/data/repositories/learning_path_repository.dart';
import 'package:duolingo_clon/models/lesson_exercise.dart';
import 'package:duolingo_clon/models/lesson_node.dart';
import 'package:duolingo_clon/providers/auth_provider.dart';
import 'package:duolingo_clon/providers/challenges_provider.dart';
import 'package:duolingo_clon/providers/league_provider.dart';
import 'package:duolingo_clon/providers/learning_path_provider.dart';
import 'package:duolingo_clon/providers/lesson_provider.dart';
import 'package:duolingo_clon/providers/profile_provider.dart';
import 'package:duolingo_clon/providers/streak_provider.dart';
import 'package:duolingo_clon/providers/user_stats_provider.dart';
import 'package:duolingo_clon/routes/app_routes.dart';
import 'package:duolingo_clon/screens/challenges/challenges_screen.dart';
import 'package:duolingo_clon/screens/home/home_screen.dart';
import 'package:duolingo_clon/screens/home/widgets/lesson_node_tile.dart';
import 'package:duolingo_clon/screens/league/league_screen.dart';
import 'package:duolingo_clon/screens/lesson/lesson_screen.dart';
import 'package:duolingo_clon/screens/lesson/widgets/lesson_progress_bar.dart';
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
  ChangeNotifierProvider<LessonProvider>(create: (_) => LessonProvider()),
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
      AppRoutes.lesson: (BuildContext context) => const LessonScreen(),
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

/// Juega la leccion 0 (comida) completa y cierra la pantalla de resultado.
Future<void> _playLesson0(WidgetTester tester) async {
  // Ejercicio 0: seleccion multiple.
  await tester.tap(find.text('the apple'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('COMPROBAR'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('CONTINUAR'));
  await tester.pumpAndSettle();

  // Ejercicio 1: banco de palabras.
  for (final String word in <String>['The', 'boy', 'eats', 'bread']) {
    await tester.tap(find.text(word));
    await tester.pumpAndSettle();
  }
  await tester.tap(find.text('COMPROBAR'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('CONTINUAR'));
  await tester.pumpAndSettle();

  // Ejercicio 2: emparejar (se valida al unir todas las parejas).
  for (final List<String> pair in <List<String>>[
    <String>['agua', 'water'],
    <String>['leche', 'milk'],
    <String>['pan', 'bread'],
  ]) {
    await tester.tap(find.text(pair[0]));
    await tester.pumpAndSettle();
    await tester.tap(find.text(pair[1]));
    await tester.pumpAndSettle();
  }
  await tester.tap(find.text('CONTINUAR'));
  await tester.pumpAndSettle();

  // Ejercicio 3: completar la oracion.
  await tester.tap(find.text('eats'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('COMPROBAR'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('CONTINUAR'));
  await tester.pumpAndSettle();

  expect(find.text('¡Lección completada!'), findsOneWidget);
  await tester.tap(find.text('CONTINUAR'));
  await tester.pumpAndSettle();
}

/// Repositorio de camino en memoria para probar estados concretos.
class _FakePathRepository implements LearningPathRepository {
  _FakePathRepository(this._nodes);

  List<LessonNode> _nodes;

  @override
  Future<List<LessonNode>> fetchNodes() async => _nodes;

  @override
  Future<void> saveNodes(List<LessonNode> nodes) async => _nodes = nodes;
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

  testWidgets('tocar el nodo activo abre la leccion', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    await _login(tester);

    await tester.tap(find.byIcon(Icons.star_rounded).first);
    await tester.pumpAndSettle();

    expect(find.text('Elige la traducción correcta'), findsOneWidget);
    expect(find.text('¿Cuál de estas es «la manzana»?'), findsOneWidget);
  });

  testWidgets('el nodo activo se dibuja arriba del camino', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    await _login(tester);

    final List<LessonNodeTile> tiles = tester
        .widgetList<LessonNodeTile>(find.byType(LessonNodeTile))
        .toList();
    expect(tiles, isNotEmpty);
    expect(tiles.first.node.status, LessonNodeStatus.active);
    expect(tiles.first.node.position, 0);
  });

  test('completeCurrent desbloquea los nodos en orden', () async {
    final LearningPathProvider path = LearningPathProvider();
    await path.load();

    expect(path.nodes.map((LessonNode n) => n.position).toList(), <int>[
      0,
      1,
      2,
      3,
      4,
      5,
      6,
    ]);
    expect(path.nodes.first.status, LessonNodeStatus.active);

    await path.completeCurrent();
    expect(path.nodes[0].status, LessonNodeStatus.completed);
    expect(path.nodes[1].status, LessonNodeStatus.active);

    await path.completeCurrent();
    expect(path.nodes[1].status, LessonNodeStatus.completed);
    expect(path.nodes[2].status, LessonNodeStatus.active);
  });

  test('completar el ultimo nodo no falla', () async {
    final LearningPathProvider path = LearningPathProvider();
    await path.load();

    for (int i = 0; i < path.nodes.length; i++) {
      await path.completeCurrent();
    }

    expect(path.nodes.last.status, LessonNodeStatus.completed);
    expect(path.activeIndex, -1);
  });

  testWidgets('completar la leccion desbloquea el siguiente nodo', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    await _login(tester);

    await tester.tap(find.byIcon(Icons.star_rounded).first);
    await tester.pumpAndSettle();

    // Ejercicio 0: seleccion multiple.
    await tester.tap(find.text('the apple'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('COMPROBAR'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONTINUAR'));
    await tester.pumpAndSettle();

    // Ejercicio 1: banco de palabras.
    for (final String word in <String>['The', 'boy', 'eats', 'bread']) {
      await tester.tap(find.text(word));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('COMPROBAR'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONTINUAR'));
    await tester.pumpAndSettle();

    // Ejercicio 2: emparejar (se valida al unir todas las parejas).
    for (final List<String> pair in <List<String>>[
      <String>['agua', 'water'],
      <String>['leche', 'milk'],
      <String>['pan', 'bread'],
    ]) {
      await tester.tap(find.text(pair[0]));
      await tester.pumpAndSettle();
      await tester.tap(find.text(pair[1]));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('CONTINUAR'));
    await tester.pumpAndSettle();

    // Ejercicio 3: completar la oracion.
    await tester.tap(find.text('eats'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('COMPROBAR'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONTINUAR'));
    await tester.pumpAndSettle();

    expect(find.text('¡Lección completada!'), findsOneWidget);
    await tester.tap(find.text('CONTINUAR'));
    await tester.pumpAndSettle();

    final BuildContext context = tester.element(find.byType(HomeScreen));
    final LearningPathProvider path = Provider.of<LearningPathProvider>(
      context,
      listen: false,
    );
    expect(path.nodes.first.status, LessonNodeStatus.completed);
    expect(path.nodes[1].status, LessonNodeStatus.active);
  });

  testWidgets('la barra avanza al pulsar continuar, no al comprobar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    await _login(tester);
    await tester.tap(find.byIcon(Icons.star_rounded).first);
    await tester.pumpAndSettle();

    LessonProgressBar bar() =>
        tester.widget<LessonProgressBar>(find.byType(LessonProgressBar));

    expect(bar().results.every((bool? r) => r == null), isTrue);

    await tester.tap(find.text('the apple'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('COMPROBAR'));
    await tester.pumpAndSettle();
    expect(bar().results.first, isNull);

    await tester.tap(find.text('CONTINUAR'));
    await tester.pumpAndSettle();
    expect(bar().results.first, isTrue);
  });

  test('un error se registra al continuar', () async {
    final LessonProvider lesson = LessonProvider();
    await lesson.start(0);

    lesson.selectOption('the bread');
    lesson.check();
    lesson.next();

    expect(lesson.results.first, isFalse);
  });

  test('al terminar no quedan resultados pendientes', () async {
    final LessonProvider lesson = LessonProvider();
    await lesson.start(0);

    while (!lesson.isFinished) {
      final LessonExercise? exercise = lesson.current;
      if (exercise == null) break;
      switch (exercise.type) {
        case LessonExerciseType.multipleChoice:
        case LessonExerciseType.fillBlank:
          lesson.selectOption(exercise.answer.first);
          lesson.check();
        case LessonExerciseType.wordBank:
          for (final String word in exercise.answer) {
            lesson.toggleWord(word);
          }
          lesson.check();
        case LessonExerciseType.matchPairs:
          for (final ExercisePair pair in exercise.pairs) {
            lesson.tapMatchLeft(pair.left);
            lesson.tapMatchRight(pair.right);
          }
      }
      lesson.next();
    }

    expect(lesson.results.every((bool? r) => r == true), isTrue);
    expect(lesson.progress, 1);
  });

  test('load activa la primera no completada si no hay activa', () async {
    final LearningPathProvider path = LearningPathProvider(
      repository: _FakePathRepository(<LessonNode>[
        const LessonNode(
          type: LessonNodeType.star,
          status: LessonNodeStatus.completed,
          position: 0,
        ),
        const LessonNode(
          type: LessonNodeType.book,
          status: LessonNodeStatus.locked,
          position: 1,
        ),
        const LessonNode(
          type: LessonNodeType.star,
          status: LessonNodeStatus.locked,
          position: 2,
        ),
      ]),
    );

    await path.load();

    expect(path.nodes[0].status, LessonNodeStatus.completed);
    expect(path.nodes[1].status, LessonNodeStatus.active);
    expect(path.nodes[2].status, LessonNodeStatus.locked);
  });

  test('load no activa nada si todas estan completas', () async {
    final LearningPathProvider path = LearningPathProvider(
      repository: _FakePathRepository(<LessonNode>[
        const LessonNode(
          type: LessonNodeType.star,
          status: LessonNodeStatus.completed,
          position: 0,
        ),
        const LessonNode(
          type: LessonNodeType.book,
          status: LessonNodeStatus.completed,
          position: 1,
        ),
      ]),
    );

    await path.load();

    expect(path.activeIndex, -1);
  });

  testWidgets('tocar un nodo completado abre la leccion', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    await _login(tester);

    final BuildContext homeContext = tester.element(find.byType(HomeScreen));
    final LearningPathProvider path = Provider.of<LearningPathProvider>(
      homeContext,
      listen: false,
    );
    for (int i = 0; i < path.nodes.length; i++) {
      await path.completeCurrent();
    }
    await tester.pumpAndSettle();
    expect(path.activeIndex, -1);

    await tester.tap(find.byIcon(Icons.star_rounded).first);
    await tester.pumpAndSettle();

    expect(find.text('Elige la traducción correcta'), findsOneWidget);
  });

  testWidgets('repetir una leccion completada no avanza y suma EXP', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    await _login(tester);

    final BuildContext homeContext = tester.element(find.byType(HomeScreen));
    final LearningPathProvider path = Provider.of<LearningPathProvider>(
      homeContext,
      listen: false,
    );
    final ChallengesProvider challenges = Provider.of<ChallengesProvider>(
      homeContext,
      listen: false,
    );
    for (int i = 0; i < path.nodes.length; i++) {
      await path.completeCurrent();
    }
    await tester.pumpAndSettle();
    expect(path.activeIndex, -1);

    final int pointsBefore = challenges.points;

    await tester.tap(find.byIcon(Icons.star_rounded).first);
    await tester.pumpAndSettle();
    await _playLesson0(tester);

    expect(path.activeIndex, -1);
    expect(challenges.points, greaterThan(pointsBefore));
  });
}
