import 'package:flutter/material.dart';

import '../models/daily_challenge.dart';
import '../models/friend_streak.dart';
import '../models/league_entry.dart';
import '../models/lesson_exercise.dart';
import '../models/lesson_node.dart';
import '../models/profile_info.dart';
import '../models/profile_showcase.dart';
import '../models/streak_calendar.dart';
import '../models/user_stats.dart';

/// Datos de prueba para las pantallas de esta fase.
///
/// Fuente unica y estatica. Al integrar Supabase, estos valores se reemplazan
/// por repositorios que devuelven los mismos modelos (`fromJson`/`toJson`).
abstract final class MockData {
  static const UserStats userStats = UserStats(
    courseFlag: '🇺🇸',
    courseCount: 69,
    streakDays: 1178,
    gems: 11696,
    hasUnlimitedHearts: true,
  );

  /// Camino de aprendizaje (boceto `home.jpeg`), de arriba hacia abajo.
  static const List<LessonNode> lessonPath = <LessonNode>[
    LessonNode(
      type: LessonNodeType.star,
      status: LessonNodeStatus.active,
      position: 0,
      horizontalOffset: 0,
    ),
    LessonNode(
      type: LessonNodeType.book,
      status: LessonNodeStatus.locked,
      position: 1,
      horizontalOffset: 0.45,
    ),
    LessonNode(
      type: LessonNodeType.star,
      status: LessonNodeStatus.locked,
      position: 2,
      horizontalOffset: 0.12,
    ),
    LessonNode(
      type: LessonNodeType.chest,
      status: LessonNodeStatus.locked,
      position: 3,
      horizontalOffset: -0.4,
    ),
    LessonNode(
      type: LessonNodeType.headphones,
      status: LessonNodeStatus.locked,
      position: 4,
      horizontalOffset: 0.22,
    ),
    LessonNode(
      type: LessonNodeType.dumbbell,
      status: LessonNodeStatus.locked,
      position: 5,
      horizontalOffset: -0.18,
    ),
    LessonNode(
      type: LessonNodeType.dialogue,
      status: LessonNodeStatus.locked,
      position: 6,
      horizontalOffset: 0.28,
    ),
  ];

  static const String sectionStage = 'ETAPA 5, SECCIÓN 100';
  static const String sectionTitle = 'Parejas: Expresa tus sentimientos';

  // --- Liga (boceto `liga.jpeg`) ---
  static const String leagueName = 'Final';
  static const int leagueDaysLeft = 4;

  static const List<LeagueEntry> leagueEntries = <LeagueEntry>[
    LeagueEntry(
      rank: 1,
      name: 'Angel AFL',
      flag: '🇺🇸',
      courseCount: 69,
      exp: 928,
      avatarColor: Color(0xFFE8A87C),
      isCurrentUser: true,
    ),
    LeagueEntry(
      rank: 2,
      name: 'Munchkin',
      flag: '🇫🇷',
      courseCount: 11,
      exp: 668,
      avatarColor: Color(0xFFB5651D),
    ),
    LeagueEntry(
      rank: 3,
      name: 'Money Witt',
      flag: '🇮🇹',
      courseCount: 13,
      exp: 466,
      avatarColor: Color(0xFFA0522D),
    ),
    LeagueEntry(
      rank: 4,
      name: 'Julian Carrasco',
      flag: '🇨🇳',
      courseCount: 10,
      exp: 359,
      avatarColor: Color(0xFFC68642),
    ),
    LeagueEntry(
      rank: 5,
      name: 'Cinthya Fernandez',
      flag: '🇺🇸',
      courseCount: 36,
      exp: 317,
      avatarColor: Color(0xFFF2C79B),
    ),
    LeagueEntry(
      rank: 6,
      name: 'Tom',
      flag: '🇪🇸',
      courseCount: 6,
      exp: 260,
      avatarColor: Color(0xFFCE82FF),
    ),
  ];

  // --- Desafios (boceto `desafios.jpeg`) ---
  static const int challengePoints = 27;
  static const int challengePointsTarget = 60;

  static const List<DailyChallenge> dailyChallenges = <DailyChallenge>[
    DailyChallenge(
      title: 'Gana 50 EXP',
      progress: 0,
      target: 50,
      reward: ChallengeReward.wood,
      metric: ChallengeMetric.exp,
    ),
    DailyChallenge(
      title: 'Consigue una racha de 3 aciertos seguidos en 2 lecciones',
      progress: 0,
      target: 2,
      reward: ChallengeReward.silver,
      metric: ChallengeMetric.streak,
    ),
    DailyChallenge(
      title: 'Obtén un puntaje de 90 % en 3 lecciones',
      progress: 0,
      target: 3,
      reward: ChallengeReward.gold,
      metric: ChallengeMetric.accuracy,
    ),
  ];

  // --- Perfil (boceto `perfil.jpeg`) ---
  static const ProfileInfo profile = ProfileInfo(
    name: 'Angel AFL',
    handle: '@MANGELMM',
    joinedYear: 2016,
    superSince: 2026,
    courses: 6,
    following: 165,
    followers: 60,
    league: 'Diamante',
    totalExp: 276837,
  );

  static const List<FriendStreak> friendStreaks = <FriendStreak>[
    FriendStreak(name: 'Alex', days: 289, avatarColor: Color(0xFFFFB4A2)),
    FriendStreak(name: 'Bruno', days: 276, avatarColor: Color(0xFF7BC950)),
    FriendStreak(name: 'Carla', days: 201, avatarColor: Color(0xFFD8B4E2)),
    FriendStreak(name: 'Diana', days: 107, avatarColor: Color(0xFF6EC1E4)),
    FriendStreak(name: 'Hugo', days: 14, avatarColor: Color(0xFFE85D5D)),
  ];

  // --- Vitrina del perfil (Súper familia, medallas y logros) ---
  static const ProfileShowcase profileShowcase = ProfileShowcase(
    family: <SuperFamilyMember>[
      SuperFamilyMember(name: 'Lucía', color: Color(0xFFB5651D)),
      SuperFamilyMember(name: 'Mateo', color: Color(0xFF7BC950)),
      SuperFamilyMember(name: 'Sofía', color: Color(0xFFF2C79B)),
      SuperFamilyMember(name: 'Diego', color: Color(0xFF6EC1E4)),
    ],
    medals: <MonthlyMedal>[
      MonthlyMedal(color: Color(0xFF1CB0F6), icon: Icons.emoji_events_rounded),
      MonthlyMedal(
        color: Color(0xFF58CC02),
        icon: Icons.local_fire_department_rounded,
      ),
      MonthlyMedal(color: Color(0xFFFF9600), icon: Icons.bolt_rounded),
      MonthlyMedal(color: Color(0xFFCE82FF), icon: Icons.school_rounded),
    ],
    achievements: <Achievement>[
      Achievement(
        value: 40,
        color: Color(0xFFFF4B4B),
        icon: Icons.menu_book_rounded,
      ),
      Achievement(
        value: 75,
        color: Color(0xFFFFC800),
        icon: Icons.local_fire_department_rounded,
      ),
      Achievement(
        value: 25,
        color: Color(0xFF1CB0F6),
        icon: Icons.diamond_rounded,
      ),
      Achievement(
        value: 1000,
        color: Color(0xFFCE82FF),
        icon: Icons.bolt_rounded,
      ),
    ],
  );

  // --- Ejercicios de las lecciones (espejo del seed de Supabase) ---
  static const List<LessonExercise> lessonExercises = <LessonExercise>[
    // Leccion 0: comida
    LessonExercise(
      id: 1,
      type: LessonExerciseType.multipleChoice,
      prompt: '¿Cuál de estas es «la manzana»?',
      options: <String>['the apple', 'the bread', 'the water', 'the milk'],
      answer: <String>['the apple'],
    ),
    LessonExercise(
      id: 2,
      type: LessonExerciseType.wordBank,
      prompt: 'Traduce: El niño come pan',
      options: <String>['The', 'boy', 'eats', 'bread', 'water', 'runs'],
      answer: <String>['The', 'boy', 'eats', 'bread'],
    ),
    LessonExercise(
      id: 3,
      type: LessonExerciseType.matchPairs,
      prompt: 'Empareja las palabras',
      pairs: <ExercisePair>[
        ExercisePair(left: 'agua', right: 'water'),
        ExercisePair(left: 'leche', right: 'milk'),
        ExercisePair(left: 'pan', right: 'bread'),
      ],
    ),
    LessonExercise(
      id: 4,
      type: LessonExerciseType.fillBlank,
      prompt: 'Ella ___ una manzana',
      options: <String>['eat', 'eats', 'eating', 'ate'],
      answer: <String>['eats'],
    ),

    // Leccion 1: animales
    LessonExercise(
      id: 5,
      type: LessonExerciseType.multipleChoice,
      prompt: '¿Cuál de estas es «el gato»?',
      options: <String>['the cat', 'the dog', 'the bird', 'the fish'],
      answer: <String>['the cat'],
    ),
    LessonExercise(
      id: 6,
      type: LessonExerciseType.wordBank,
      prompt: 'Traduce: La niña tiene un perro',
      options: <String>['The', 'girl', 'has', 'a', 'dog', 'cat', 'runs'],
      answer: <String>['The', 'girl', 'has', 'a', 'dog'],
    ),
    LessonExercise(
      id: 7,
      type: LessonExerciseType.matchPairs,
      prompt: 'Empareja las palabras',
      pairs: <ExercisePair>[
        ExercisePair(left: 'caballo', right: 'horse'),
        ExercisePair(left: 'pájaro', right: 'bird'),
        ExercisePair(left: 'pez', right: 'fish'),
      ],
    ),
    LessonExercise(
      id: 8,
      type: LessonExerciseType.fillBlank,
      prompt: 'El perro ___ en el parque',
      options: <String>['run', 'runs', 'running', 'ran'],
      answer: <String>['runs'],
    ),

    // Leccion 2: familia
    LessonExercise(
      id: 9,
      type: LessonExerciseType.multipleChoice,
      prompt: '¿Cuál de estas es «la madre»?',
      options: <String>[
        'the mother',
        'the father',
        'the sister',
        'the brother',
      ],
      answer: <String>['the mother'],
    ),
    LessonExercise(
      id: 10,
      type: LessonExerciseType.wordBank,
      prompt: 'Traduce: Mi hermana es médica',
      options: <String>[
        'My',
        'sister',
        'is',
        'a',
        'doctor',
        'brother',
        'teacher',
      ],
      answer: <String>['My', 'sister', 'is', 'a', 'doctor'],
    ),
    LessonExercise(
      id: 11,
      type: LessonExerciseType.matchPairs,
      prompt: 'Empareja las palabras',
      pairs: <ExercisePair>[
        ExercisePair(left: 'padre', right: 'father'),
        ExercisePair(left: 'hermano', right: 'brother'),
        ExercisePair(left: 'abuela', right: 'grandmother'),
      ],
    ),
    LessonExercise(
      id: 12,
      type: LessonExerciseType.fillBlank,
      prompt: 'Mi ___ trabaja en casa',
      options: <String>['father', 'mother', 'parents', 'brothers'],
      answer: <String>['father'],
    ),

    // Leccion 3: colores
    LessonExercise(
      id: 13,
      type: LessonExerciseType.multipleChoice,
      prompt: '¿Cuál de estas es «rojo»?',
      options: <String>['red', 'blue', 'green', 'yellow'],
      answer: <String>['red'],
    ),
    LessonExercise(
      id: 14,
      type: LessonExerciseType.wordBank,
      prompt: 'Traduce: La flor es amarilla',
      options: <String>['The', 'flower', 'is', 'yellow', 'red', 'green'],
      answer: <String>['The', 'flower', 'is', 'yellow'],
    ),
    LessonExercise(
      id: 15,
      type: LessonExerciseType.matchPairs,
      prompt: 'Empareja los colores',
      pairs: <ExercisePair>[
        ExercisePair(left: 'azul', right: 'blue'),
        ExercisePair(left: 'verde', right: 'green'),
        ExercisePair(left: 'negro', right: 'black'),
      ],
    ),
    LessonExercise(
      id: 16,
      type: LessonExerciseType.fillBlank,
      prompt: 'El cielo es ___',
      options: <String>['blue', 'red', 'green', 'black'],
      answer: <String>['blue'],
    ),

    // Leccion 4: numeros
    LessonExercise(
      id: 17,
      type: LessonExerciseType.multipleChoice,
      prompt: '¿Cuál de estas es «tres»?',
      options: <String>['three', 'two', 'four', 'five'],
      answer: <String>['three'],
    ),
    LessonExercise(
      id: 18,
      type: LessonExerciseType.wordBank,
      prompt: 'Traduce: Tengo dos hermanos',
      options: <String>['I', 'have', 'two', 'brothers', 'three', 'sisters'],
      answer: <String>['I', 'have', 'two', 'brothers'],
    ),
    LessonExercise(
      id: 19,
      type: LessonExerciseType.matchPairs,
      prompt: 'Empareja los números',
      pairs: <ExercisePair>[
        ExercisePair(left: 'uno', right: 'one'),
        ExercisePair(left: 'cinco', right: 'five'),
        ExercisePair(left: 'diez', right: 'ten'),
      ],
    ),
    LessonExercise(
      id: 20,
      type: LessonExerciseType.fillBlank,
      prompt: 'Hay ___ manzanas',
      options: <String>['four', 'for', 'fore', 'fourth'],
      answer: <String>['four'],
    ),

    // Leccion 5: acciones
    LessonExercise(
      id: 21,
      type: LessonExerciseType.multipleChoice,
      prompt: '¿Cuál de estas es «correr»?',
      options: <String>['to run', 'to eat', 'to sleep', 'to read'],
      answer: <String>['to run'],
    ),
    LessonExercise(
      id: 22,
      type: LessonExerciseType.wordBank,
      prompt: 'Traduce: Ella lee un libro',
      options: <String>['She', 'reads', 'a', 'book', 'runs', 'writes'],
      answer: <String>['She', 'reads', 'a', 'book'],
    ),
    LessonExercise(
      id: 23,
      type: LessonExerciseType.matchPairs,
      prompt: 'Empareja los verbos',
      pairs: <ExercisePair>[
        ExercisePair(left: 'comer', right: 'to eat'),
        ExercisePair(left: 'beber', right: 'to drink'),
        ExercisePair(left: 'dormir', right: 'to sleep'),
      ],
    ),
    LessonExercise(
      id: 24,
      type: LessonExerciseType.fillBlank,
      prompt: 'Nosotros ___ español',
      options: <String>['speak', 'speaks', 'speaking', 'spoke'],
      answer: <String>['speak'],
    ),

    // Leccion 6: sentimientos
    LessonExercise(
      id: 25,
      type: LessonExerciseType.multipleChoice,
      prompt: '¿Cuál de estas es «feliz»?',
      options: <String>['happy', 'sad', 'tired', 'angry'],
      answer: <String>['happy'],
    ),
    LessonExercise(
      id: 26,
      type: LessonExerciseType.wordBank,
      prompt: 'Traduce: Estoy muy contento',
      options: <String>['I', 'am', 'very', 'happy', 'sad', 'tired'],
      answer: <String>['I', 'am', 'very', 'happy'],
    ),
    LessonExercise(
      id: 27,
      type: LessonExerciseType.matchPairs,
      prompt: 'Empareja los sentimientos',
      pairs: <ExercisePair>[
        ExercisePair(left: 'triste', right: 'sad'),
        ExercisePair(left: 'cansado', right: 'tired'),
        ExercisePair(left: 'enojado', right: 'angry'),
      ],
    ),
    LessonExercise(
      id: 28,
      type: LessonExerciseType.fillBlank,
      prompt: 'Ella está ___ hoy',
      options: <String>['happy', 'happiness', 'happily', 'happen'],
      answer: <String>['happy'],
    ),
  ];

  // --- Rachas (boceto `rachas.jpeg`) ---
  static const StreakCalendar streakCalendar = StreakCalendar(
    monthName: 'septiembre',
    year: 2026,
    practiceDays: 8,
    freezesUsed: 0,
    perfectWeeks: 4,
    activeDays: <int>[1, 2, 3, 4, 5, 6, 7, 8],
    today: 9,
  );
}
