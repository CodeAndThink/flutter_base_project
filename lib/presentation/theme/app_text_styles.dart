import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Shared typography. Static styles inherit color and font from DefaultTextStyle.
/// The application theme supplies Nunito and light/dark text colors.
abstract final class AppTextStyles {
  static const displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400,
  );
  static const displayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w400,
  );
  static const displaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400,
  );
  static const headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
  static const headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
  static const headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.15,
  );
  static const titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.1,
  );
  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );
  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );
  static const bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );
  static const labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );
  static const labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
  static const labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  // Partial styles retain DefaultTextStyle inheritance at their call sites.
  static const movieTitle = TextStyle(fontWeight: FontWeight.bold);
  static const movieRating = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const movieRelease = TextStyle(fontSize: 16);
  static const movieOverviewTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  static const movieOverviewBody = TextStyle(fontSize: 16, height: 1.5);
  static const imageTitle = TextStyle(
    shadows: [Shadow(color: Colors.black, blurRadius: 4)],
  );

  static TextTheme buildTextTheme({required bool isDarkMode}) {
    final color = isDarkMode ? const Color(0xFFD6D6D6) : Colors.black;
    return GoogleFonts.nunitoTextTheme(
      const TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
      ),
    ).apply(bodyColor: color, displayColor: color);
  }
}
