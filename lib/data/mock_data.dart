import 'package:flutter/material.dart';

import '../models/daily_challenge.dart';
import '../models/friend_streak.dart';
import '../models/league_entry.dart';
import '../models/lesson_node.dart';
import '../models/profile_info.dart';
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
      horizontalOffset: 0,
    ),
    LessonNode(
      type: LessonNodeType.book,
      status: LessonNodeStatus.locked,
      horizontalOffset: 0.45,
    ),
    LessonNode(
      type: LessonNodeType.star,
      status: LessonNodeStatus.locked,
      horizontalOffset: 0.12,
    ),
    LessonNode(
      type: LessonNodeType.chest,
      status: LessonNodeStatus.locked,
      horizontalOffset: -0.4,
    ),
    LessonNode(
      type: LessonNodeType.headphones,
      status: LessonNodeStatus.locked,
      horizontalOffset: 0.22,
    ),
    LessonNode(
      type: LessonNodeType.dumbbell,
      status: LessonNodeStatus.locked,
      horizontalOffset: -0.18,
    ),
    LessonNode(
      type: LessonNodeType.dialogue,
      status: LessonNodeStatus.locked,
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
  static const String challengeMonth = 'septiembre';
  static const int challengeDaysLeft = 21;
  static const int challengePoints = 27;
  static const int challengePointsTarget = 60;
  static const String challengePartner = 'Roxsana';
  static const int challengePartnerExp = 422;

  static const List<DailyChallenge> dailyChallenges = <DailyChallenge>[
    DailyChallenge(
      title: 'Gana 50 EXP',
      progress: 0,
      target: 50,
      reward: ChallengeReward.wood,
    ),
    DailyChallenge(
      title: 'Responde correctamente 5 veces seguidas en 2 lecciones',
      progress: 0,
      target: 2,
      reward: ChallengeReward.silver,
    ),
    DailyChallenge(
      title: 'Obtén un puntaje de 90 % en 3 lecciones',
      progress: 0,
      target: 3,
      reward: ChallengeReward.gold,
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
