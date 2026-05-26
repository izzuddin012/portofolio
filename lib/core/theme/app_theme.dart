import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devolio_flutter/core/theme/app_colors.dart';

class AppTheme {
  static TextTheme _text(TextTheme base, Color body) =>
      GoogleFonts.interTextTheme(base).apply(
        bodyColor: body,
        displayColor: body,
      );

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        secondary: AppColors.warm,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        outline: AppColors.border,
      ),
      textTheme: _text(base.textTheme, AppColors.textPrimary),
      cardColor: AppColors.card,
      dividerColor: AppColors.border,
      inputDecorationTheme: _input(
        fill: AppColors.card,
        border: AppColors.border,
        focus: AppColors.accent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.bg,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          textStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w500, fontSize: 13, letterSpacing: 0.3),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.border),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          textStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w400, fontSize: 13, letterSpacing: 0.3),
        ),
      ),
    );
  }

  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.lightBg,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accent,
        secondary: AppColors.warm,
        onSurface: AppColors.lightTextPrimary,
        outline: AppColors.lightBorder,
      ),
      textTheme: _text(base.textTheme, AppColors.lightTextPrimary),
      cardColor: AppColors.lightCard,
      dividerColor: AppColors.lightBorder,
      inputDecorationTheme: _input(
        fill: AppColors.lightSurface,
        border: AppColors.lightBorder,
        focus: AppColors.accent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          textStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w500, fontSize: 13, letterSpacing: 0.3),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.lightTextPrimary,
          side: const BorderSide(color: AppColors.lightBorder),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          textStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w400, fontSize: 13, letterSpacing: 0.3),
        ),
      ),
    );
  }

  static InputDecorationTheme _input({
    required Color fill,
    required Color border,
    required Color focus,
  }) =>
      InputDecorationTheme(
        filled: true,
        fillColor: fill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: focus, width: 1.5),
        ),
        labelStyle:
            const TextStyle(color: AppColors.textSecondary, fontSize: 14),
        hintStyle:
            const TextStyle(color: AppColors.textMuted, fontSize: 14),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      );
}
