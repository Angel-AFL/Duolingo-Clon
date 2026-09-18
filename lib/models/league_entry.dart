import 'package:flutter/material.dart';

/// Fila de la tabla de posiciones de la liga.
class LeagueEntry {
  const LeagueEntry({
    required this.rank,
    required this.name,
    required this.flag,
    required this.courseCount,
    required this.exp,
    required this.avatarColor,
    this.isCurrentUser = false,
  });

  /// Posicion en la liga (1 = primero).
  final int rank;

  final String name;

  /// Bandera (emoji) del curso.
  final String flag;

  /// Numero mostrado junto a la bandera.
  final int courseCount;

  /// Experiencia acumulada en la liga.
  final int exp;

  /// Color del avatar placeholder.
  final Color avatarColor;

  /// Si es la fila del usuario actual.
  final bool isCurrentUser;

  LeagueEntry copyWith({int? rank, int? exp}) {
    return LeagueEntry(
      rank: rank ?? this.rank,
      name: name,
      flag: flag,
      courseCount: courseCount,
      exp: exp ?? this.exp,
      avatarColor: avatarColor,
      isCurrentUser: isCurrentUser,
    );
  }

  factory LeagueEntry.fromJson(Map<String, dynamic> json) {
    return LeagueEntry(
      rank: json['rank'] as int,
      name: json['name'] as String,
      flag: json['flag'] as String,
      courseCount: json['course_count'] as int,
      exp: json['exp'] as int,
      avatarColor: Color(json['avatar_color'] as int),
      isCurrentUser: json['is_current_user'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'rank': rank,
    'name': name,
    'flag': flag,
    'course_count': courseCount,
    'exp': exp,
    'avatar_color': avatarColor.toARGB32(),
    'is_current_user': isCurrentUser,
  };
}
