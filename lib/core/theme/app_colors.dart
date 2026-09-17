import 'package:flutter/material.dart';

/// Tokens de color del sistema de diseño Duolingo (skill `duolingo`).
///
/// El skill define el tema claro de la web de marketing. Las pantallas de la
/// app (bocetos en `/docs`) son de tema oscuro, por lo que se agrega una
/// extension `dark*` que conserva los acentos originales.
abstract final class AppColors {
  // --- Paleta base del skill ---
  static const Color eagerGreen = Color(0xFF58CC02);
  static const Color storybookGreen = Color(0xFFD7FFB8);
  static const Color sparkBlue = Color(0xFF1CB0F6);
  static const Color freshLeaf = Color(0xFFA5ED6E);
  static const Color nightInk = Color(0xFF000437);
  static const Color paperWhite = Color(0xFFFFFFFF);
  static const Color charcoal = Color(0xFF4B4B4B);
  static const Color pencilGray = Color(0xFF777777);
  static const Color fadedGray = Color(0xFFAFAFAF);

  // --- Superficies del skill ---
  static const Color surfacePaperWhite = paperWhite;
  static const Color surfaceStorybookGreen = storybookGreen;
  static const Color surfaceEagerGreen = eagerGreen;
  static const Color surfaceNightInk = nightInk;

  // --- Extension para el tema oscuro de la app (bocetos) ---
  static const Color darkBackground = Color(0xFF131F24);
  static const Color darkSurface = Color(0xFF1E2D35);
  static const Color darkSurfaceAlt = Color(0xFF223038);
  static const Color darkBorder = Color(0xFF37464F);
  static const Color lockedNode = Color(0xFF2B3A42);
  static const Color pathLockedText = Color(0xFF52656D);

  // --- Acentos de la app ---
  static const Color streakOrange = Color(0xFFFF9600);
  static const Color streakDeep = Color(0xFFE5591E);
  static const Color gemBlue = Color(0xFF1CB0F6);
  static const Color heartPink = Color(0xFFFF4B4B);
  static const Color leaguePurple = Color(0xFFCE82FF);
  static const Color superViolet = Color(0xFF9069F3);
}
