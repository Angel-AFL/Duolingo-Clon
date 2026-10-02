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

  // --- Lips 3D (tono mas oscuro bajo cada boton/ficha) ---
  static const Color eagerGreenLip = Color(0xFF58A700);
  static const Color sparkBlueLip = Color(0xFF1899D6);
  static const Color heartPinkLip = Color(0xFFCC3B3B);
  static const Color streakOrangeLip = Color(0xFFCC7A00);
  static const Color superVioletLip = Color(0xFFA560E8);
  static const Color leaguePurpleLip = Color(0xFFA560E8);
  static const Color darkSurfaceLip = Color(0xFF16232A);
  static const Color lockedNodeLip = Color(0xFF22323A);

  // --- Feedback de leccion (modo oscuro) ---
  static const Color feedbackCorrectBg = Color(0xFF1D3A22);
  static const Color feedbackWrongBg = Color(0xFF3A2228);

  // --- Desafios ---
  static const Color challengePanel = Color(0xFF3A2E1E);

  // --- Icono de perfil del nav (silueta en dos tonos) ---
  static const Color navProfileHead = Color(0xFF4FC3F7);
  static const Color navProfileBody = Color(0xFF1899D6);

  // --- Liga ---
  static const Color leagueGradientStart = Color(0xFF6C4CF1);
  static const Color leagueGradientEnd = Color(0xFF1CB0F6);
  static const Color leagueRowAlt = Color(0xFF1A272E);
  static const Color podiumGold = Color(0xFFFFC800);
  static const Color podiumSilver = Color(0xFFBFC5CC);
  static const Color podiumBronze = Color(0xFFCD7F32);

  // --- Perfil ---
  static const Color profileYellow = Color(0xFFF9E27D);
  static const Color avatarSkin = Color(0xFFF3B98E);

  // --- Superficies y barras de progreso ---
  static const Color darkCard = Color(0xFF1A262C);
  static const Color progressTrack = Color(0xFF37464F);
  static const Color superPink = Color(0xFFFF4FA3);
  static const Color rewardTeal = Color(0xFF2B6E7F);

  /// Velo oscuro para superponer sobre avatares/imagenes al actualizar.
  static const Color scrim = Color(0x66000000);
}
