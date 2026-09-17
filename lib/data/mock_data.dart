import '../models/lesson_node.dart';
import '../models/user_stats.dart';

/// Datos de prueba para las pantallas de esta fase.
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
}
