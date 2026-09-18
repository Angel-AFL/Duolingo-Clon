import 'package:flutter/material.dart';

/// Racha compartida con un amigo.
class FriendStreak {
  const FriendStreak({
    required this.name,
    required this.days,
    required this.avatarColor,
  });

  final String name;
  final int days;
  final Color avatarColor;

  factory FriendStreak.fromJson(Map<String, dynamic> json) {
    return FriendStreak(
      name: json['name'] as String,
      days: json['days'] as int,
      avatarColor: Color(json['avatar_color'] as int),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'days': days,
    'avatar_color': avatarColor.toARGB32(),
  };
}
