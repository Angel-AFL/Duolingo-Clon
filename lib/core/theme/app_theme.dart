import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

/// Temas de la app.
///
/// - `light`: pantalla de login (Paper White, segun el skill).
/// - `dark`: pantallas de la app (bocetos en `/docs`).
///
/// Los estilos de componentes (botones, inputs, sheets...) se centralizan aqui
/// para no repetirlos en cada widget.
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
    ).copyWith(
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      dialogTheme: _dialogTheme,
      bottomSheetTheme: _bottomSheetTheme,
      snackBarTheme: _snackBarTheme,
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
    ).copyWith(
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _inputDecorationTheme,
      dividerTheme: const DividerThemeData(color: AppColors.darkBorder),
      dialogTheme: _dialogTheme,
      bottomSheetTheme: _bottomSheetTheme,
      snackBarTheme: _snackBarTheme,
      tabBarTheme: const TabBarThemeData(
        labelColor: AppColors.sparkBlue,
        unselectedLabelColor: AppColors.pencilGray,
        indicatorColor: AppColors.sparkBlue,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: AppColors.darkBorder,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w800,
          letterSpacing: 1,
          fontSize: 14,
        ),
      ),
    );
  }

  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.eagerGreen,
          foregroundColor: AppColors.paperWhite,
          disabledBackgroundColor: AppColors.fadedGray,
          disabledForegroundColor: AppColors.paperWhite,
          elevation: 0,
          shadowColor: Colors.transparent,
          minimumSize: const Size(0, 52),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.standard),
          ),
        ),
      );

  static final OutlinedButtonThemeData _outlinedButtonTheme =
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.paperWhite,
          side: const BorderSide(color: AppColors.darkBorder, width: 2),
          minimumSize: const Size(0, 52),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.standard),
          ),
        ),
      );

  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: AppColors.sparkBlue),
  );

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
        filled: true,
        fillColor: AppColors.paperWhite,
        labelStyle: TextStyle(color: AppColors.pencilGray),
        prefixIconColor: AppColors.fadedGray,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.standard),
          borderSide: const BorderSide(color: AppColors.fadedGray, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.standard),
          borderSide: const BorderSide(color: AppColors.sparkBlue, width: 2),
        ),
      );

  static final DialogThemeData _dialogTheme = DialogThemeData(
    backgroundColor: AppColors.darkSurface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.standard),
    ),
  );

  static final BottomSheetThemeData _bottomSheetTheme = BottomSheetThemeData(
    backgroundColor: AppColors.darkSurface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppRadius.standard),
      ),
    ),
  );

  static final SnackBarThemeData _snackBarTheme = SnackBarThemeData(
    backgroundColor: AppColors.darkSurfaceAlt,
    contentTextStyle: TextStyle(color: AppColors.paperWhite),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.standard),
    ),
  );
}
