import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tipografia del sistema de diseno Duolingo.
///
/// El skill usa `feather` (display) y `duolingo-sans` (cuerpo). Se sustituyen
/// por **Nunito** (Google Fonts), la alternativa redondeada mas cercana.
abstract final class AppTypography {
  static const String _family = 'Nunito';

  /// feather 700 — titulares display de seccion (48px).
  static TextStyle display({Color? color}) => GoogleFonts.getFont(
        _family,
        fontSize: 48,
        fontWeight: FontWeight.w900,
        height: 1.2,
        letterSpacing: -0.96,
        color: color,
      );

  /// feather 700 — display grande (64px).
  static TextStyle displayLarge({Color? color}) => GoogleFonts.getFont(
        _family,
        fontSize: 64,
        fontWeight: FontWeight.w900,
        height: 1.2,
        letterSpacing: -1.28,
        color: color,
      );

  /// duolingo-sans 700 — subheading grande (32px).
  static TextStyle headingSm({Color? color}) => GoogleFonts.getFont(
        _family,
        fontSize: 32,
        fontWeight: FontWeight.w800,
        height: 1.2,
        color: color,
      );

  /// duolingo-sans 700 — subheading (19px).
  static TextStyle subheading({Color? color}) => GoogleFonts.getFont(
        _family,
        fontSize: 19,
        fontWeight: FontWeight.w700,
        height: 1.4,
        color: color,
      );

  /// duolingo-sans 700 — nav labels (15px, uppercase + tracking).
  static TextStyle navLabel({Color? color}) => GoogleFonts.getFont(
        _family,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        height: 1.33,
        letterSpacing: 0.795,
        color: color,
      );

  /// duolingo-sans 500/600 — cuerpo (17px).
  static TextStyle body({Color? color}) => GoogleFonts.getFont(
        _family,
        fontSize: 17,
        fontWeight: FontWeight.w600,
        height: 1.18,
        color: color,
      );

  /// duolingo-sans — caption (13px).
  static TextStyle caption({Color? color}) => GoogleFonts.getFont(
        _family,
        fontSize: 13,
        fontWeight: FontWeight.w700,
        height: 1.23,
        color: color,
      );

  /// Texto de valores numericos en la barra de stats.
  static TextStyle statValue({Color? color}) => GoogleFonts.getFont(
        _family,
        fontSize: 17,
        fontWeight: FontWeight.w800,
        height: 1.1,
        color: color,
      );
}
