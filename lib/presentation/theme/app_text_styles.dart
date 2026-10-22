import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central typography configuration and styles resolved from the active theme.
class AppTextStyles {
  final TextTheme _theme;
  const AppTextStyles(this._theme);

  TextStyle get displayLarge => _theme.displayLarge ?? const TextStyle();
  TextStyle get displayMedium => _theme.displayMedium ?? const TextStyle();
  TextStyle get displaySmall => _theme.displaySmall ?? const TextStyle();
  TextStyle get headlineLarge => _theme.headlineLarge ?? const TextStyle();
  TextStyle get headlineMedium => _theme.headlineMedium ?? const TextStyle();
  TextStyle get headlineSmall => _theme.headlineSmall ?? const TextStyle();
  TextStyle get titleLarge => _theme.titleLarge ?? const TextStyle();
  TextStyle get titleMedium => _theme.titleMedium ?? const TextStyle();
  TextStyle get titleSmall => _theme.titleSmall ?? const TextStyle();
  TextStyle get bodyLarge => _theme.bodyLarge ?? const TextStyle();
  TextStyle get bodyMedium => _theme.bodyMedium ?? const TextStyle();
  TextStyle get bodySmall => _theme.bodySmall ?? const TextStyle();
  TextStyle get labelLarge => _theme.labelLarge ?? const TextStyle();
  TextStyle get labelMedium => _theme.labelMedium ?? const TextStyle();
  TextStyle get labelSmall => _theme.labelSmall ?? const TextStyle();

  // Partial styles retain DefaultTextStyle inheritance at their call sites.
  TextStyle get movieTitle => const TextStyle(fontWeight: FontWeight.bold);
  TextStyle get movieRating =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle get movieRelease => const TextStyle(fontSize: 16);
  TextStyle get movieOverviewTitle =>
      const TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  TextStyle get movieOverviewBody => const TextStyle(fontSize: 16, height: 1.5);
  TextStyle get imageTitle =>
      const TextStyle(shadows: [Shadow(color: Colors.black, blurRadius: 4)]);

  static TextTheme buildTextTheme({required bool isDarkMode}) {
    final textColor = isDarkMode ? const Color(0xFFD6D6D6) : Colors.black;
    return GoogleFonts.nunitoTextTheme().copyWith(
      displayLarge: GoogleFonts.nunito(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      displayMedium: GoogleFonts.nunito(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      displaySmall: GoogleFonts.nunito(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      headlineLarge: GoogleFonts.nunito(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      headlineMedium: GoogleFonts.nunito(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      headlineSmall: GoogleFonts.nunito(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      titleLarge: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      titleMedium: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: 0.1,
      ),
      bodyLarge: GoogleFonts.nunito(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.5,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.25,
      ),
      bodySmall: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.4,
      ),
      labelLarge: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.nunito(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.5,
      ),
    );
  }
}
