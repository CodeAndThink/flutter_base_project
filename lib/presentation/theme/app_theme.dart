import 'package:flutter/material.dart';
import 'app_text_styles.dart';
import '../../core/constants/app_colors.dart';

class AppTheme {
  static ThemeData light({Color seedColor = AppColors.seed}) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
      error: Colors.red,
      surface: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: AppTextStyles.buildTextTheme(isDarkMode: false),
      scrollbarTheme: ScrollbarThemeData(
        thumbVisibility: const WidgetStatePropertyAll(true),
        thumbColor: WidgetStatePropertyAll(colorScheme.primary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStatePropertyAll(colorScheme.onSurface),
        ),
      ),
      dividerColor: colorScheme.outlineVariant,
    );
  }

  static ThemeData dark({Color seedColor = AppColors.seed}) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
      error: Colors.red,
      surface: Color(0xFF121212),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: AppTextStyles.buildTextTheme(isDarkMode: true),
      scrollbarTheme: ScrollbarThemeData(
        thumbVisibility: const WidgetStatePropertyAll(true),
        thumbColor: WidgetStatePropertyAll(colorScheme.primary),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      dividerColor: colorScheme.outlineVariant,
    );
  }
}
