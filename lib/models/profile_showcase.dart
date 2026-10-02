import 'package:flutter/material.dart';

/// Miembro de la Súper familia (fila de avatares del perfil).
class SuperFamilyMember {
  const SuperFamilyMember({required this.name, required this.color});

  final String name;
  final Color color;
}

/// Medalla mensual (insignia circular con anillo de color).
class MonthlyMedal {
  const MonthlyMedal({required this.color, required this.icon});

  final Color color;
  final IconData icon;
}

/// Logro desbloqueado (insignia con valor numerico).
class Achievement {
  const Achievement({
    required this.value,
    required this.color,
    required this.icon,
  });

  final int value;
  final Color color;
  final IconData icon;
}

/// Datos estaticos de las secciones de vitrina del perfil.
class ProfileShowcase {
  const ProfileShowcase({
    required this.family,
    required this.medals,
    required this.achievements,
  });

  final List<SuperFamilyMember> family;
  final List<MonthlyMedal> medals;
  final List<Achievement> achievements;
}
