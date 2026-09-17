import 'package:flutter/material.dart';

/// Tipo de nodo dentro del camino de aprendizaje.
enum LessonNodeType { star, book, chest, headphones, dumbbell, dialogue }

/// Estado del nodo.
enum LessonNodeStatus { active, completed, locked }

/// Un nodo del camino sinuoso de lecciones.
class LessonNode {
  const LessonNode({
    required this.type,
    required this.status,
    this.horizontalOffset = 0,
  });

  final LessonNodeType type;
  final LessonNodeStatus status;

  /// Desplazamiento horizontal normalizado (-1 a 1) para dibujar el zigzag.
  final double horizontalOffset;

  IconData get icon {
    switch (type) {
      case LessonNodeType.star:
        return Icons.star_rounded;
      case LessonNodeType.book:
        return Icons.menu_book_rounded;
      case LessonNodeType.chest:
        return Icons.inventory_2_rounded;
      case LessonNodeType.headphones:
        return Icons.headphones_rounded;
      case LessonNodeType.dumbbell:
        return Icons.fitness_center_rounded;
      case LessonNodeType.dialogue:
        return Icons.forum_rounded;
    }
  }
}
