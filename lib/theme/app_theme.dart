import 'package:flutter/material.dart';

/// Clean, Minimal Theme - Inspired by Kettlebell App & RP Hypertrophy
/// Color palette: Emerald green, forest green, white, deep silver
class AppTheme {
  // ═══════════════════════════════════════════════════════════════════════════
  // PRIMARY COLORS - Warm Forest/Emerald Greens
  // ═══════════════════════════════════════════════════════════════════════════
  
  static const Color primary = Color(0xFF2D6A4F);          // Forest green
  static const Color primaryLight = Color(0xFF40916C);     // Light forest
  static const Color primaryDark = Color(0xFF1B4332);      // Dark forest
  static const Color accent = Color(0xFF52B788);           // Emerald green
  static const Color accentLight = Color(0xFF74C69D);      // Light emerald
  
  // ═══════════════════════════════════════════════════════════════════════════
  // BACKGROUND COLORS - Clean dark with warmth
  // ═══════════════════════════════════════════════════════════════════════════
  
  static const Color bgPrimary = Color(0xFF0D1117);        // Deep dark
  static const Color bgSecondary = Color(0xFF161B22);      // Card background
  static const Color bgTertiary = Color(0xFF21262D);       // Elevated surface
  static const Color bgCard = Color(0xFF1C2128);           // Card surface
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SILVER/NEUTRAL TONES
  // ═══════════════════════════════════════════════════════════════════════════
  
  static const Color silver = Color(0xFF8B949E);           // Deep silver
  static const Color silverLight = Color(0xFFC9D1D9);      // Light silver
  static const Color silverDark = Color(0xFF6E7681);       // Dark silver
  
  // ═══════════════════════════════════════════════════════════════════════════
  // TEXT COLORS
  // ═══════════════════════════════════════════════════════════════════════════
  
  static const Color textPrimary = Color(0xFFF0F6FC);      // White/off-white
  static const Color textSecondary = Color(0xFFC9D1D9);    // Light silver
  static const Color textMuted = Color(0xFF8B949E);        // Muted silver
  static const Color textDisabled = Color(0xFF484F58);     // Disabled
  
  // ═══════════════════════════════════════════════════════════════════════════
  // BORDERS
  // ═══════════════════════════════════════════════════════════════════════════
  
  static const Color border = Color(0xFF30363D);           // Standard border
  static const Color borderLight = Color(0xFF21262D);      // Subtle border
  static const Color borderFocus = Color(0xFF2D6A4F);      // Focus state
  
  // ═══════════════════════════════════════════════════════════════════════════
  // WORKOUT STATE COLORS - Clean, no heavy gradients
  // ═══════════════════════════════════════════════════════════════════════════
  
  static const Color stateWork = Color(0xFF52B788);        // Emerald - Work
  static const Color stateRest = Color(0xFF58A6FF);        // Blue - Rest
  static const Color stateBreak = Color(0xFFA371F7);       // Purple - Break
  static const Color stateComplete = Color(0xFF3FB950);    // Green - Complete
  
  // ═══════════════════════════════════════════════════════════════════════════
  // SPACING
  // ═══════════════════════════════════════════════════════════════════════════
  
  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 24.0;
  static const double spaceXl = 32.0;
  static const double space2xl = 48.0;

  // ═══════════════════════════════════════════════════════════════════════════
  // RADIUS
  // ═══════════════════════════════════════════════════════════════════════════
  
  static const double radiusSm = 6.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;

  // ═══════════════════════════════════════════════════════════════════════════
  // THEME DATA
  // ═══════════════════════════════════════════════════════════════════════════
  
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bgPrimary,
      primaryColor: primary,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        secondary: accent,
        surface: bgCard,
        onSurface: textPrimary,
      ),
      fontFamily: 'SF Pro Display',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.w300,
          color: textPrimary,
          letterSpacing: -2,
        ),
        displayMedium: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w300,
          color: textPrimary,
          letterSpacing: -1,
        ),
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textMuted,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textPrimary,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: textMuted,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
