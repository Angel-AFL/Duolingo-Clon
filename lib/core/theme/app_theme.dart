import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Temas de la app.
///
/// - `light`: pantalla de login (Paper White, segun el skill).
/// - `dark`: pantallas de la app (bocetos en `/docs`).
abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.eagerGreen,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.eagerGreen,
          secondary: AppColors.sparkBlue,
          surface: AppColors.paperWhite,
          onSurface: AppColors.charcoal,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.paperWhite,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.nunitoTextTheme(ThemeData.light().textTheme),
    );
  }

  static ThemeData get dark {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.eagerGreen,
          brightness: Brightness.dark,
        ).copyWith(
          primary: AppColors.eagerGreen,
          secondary: AppColors.sparkBlue,
          surface: AppColors.darkSurface,
          onSurface: AppColors.paperWhite,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.nunitoTextTheme(ThemeData.dark().textTheme),
    );
  }
}
