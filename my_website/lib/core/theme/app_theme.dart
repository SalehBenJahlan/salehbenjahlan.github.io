import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.scaffoldDark,
      canvasColor: AppColors.scaffoldDark,
      cardColor: AppColors.cardDark,
      dividerColor: AppColors.borderDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.purple,
        secondary: AppColors.cyan,
        surface: AppColors.surfaceDark,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 56,
          fontWeight: FontWeight.w800,
          color: AppColors.white,
          height: 1.1,
          letterSpacing: -1.5,
        ),
        displayMedium: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
          height: 1.2,
          letterSpacing: -0.5,
        ),
        displaySmall: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.grey300,
          height: 1.7,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.grey300,
          height: 1.6,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.grey500,
          letterSpacing: 0.5,
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.grey300),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.scaffoldLight,
      canvasColor: AppColors.scaffoldLight,
      cardColor: AppColors.cardLight,
      dividerColor: AppColors.borderLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.purple,
        secondary: AppColors.cyan,
        surface: AppColors.surfaceLight,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 56,
          fontWeight: FontWeight.w800,
          color: AppColors.dark900,
          height: 1.1,
          letterSpacing: -1.5,
        ),
        displayMedium: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w700,
          color: AppColors.dark900,
          height: 1.2,
          letterSpacing: -0.5,
        ),
        displaySmall: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.dark900,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.dark900,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.dark900,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.dark900,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.dark500,
          height: 1.7,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.dark500,
          height: 1.6,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.dark900,
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.dark700,
          letterSpacing: 0.5,
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.dark500),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}

