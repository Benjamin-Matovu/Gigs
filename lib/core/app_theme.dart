// ============================================================
// lib/core/app_theme.dart
// CENTRALISED THEME — One file controls the entire app's look.
// To rebrand Tumma, only change values here.
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TummaColors {
  // Primary brand palette
  static const teal        = Color(0xFF006064); // Deep Teal — trust, professionalism
  static const tealLight   = Color(0xFF00838F); // Lighter teal for gradients
  static const tealBg      = Color(0xFFE0F2F1); // Soft teal for card backgrounds
  static const amber       = Color(0xFFFFB300); // Amber — energy, calls to action
  static const amberLight  = Color(0xFFFFCA28); // Lighter amber for hover states
  static const amberBg     = Color(0xFFFFF8E1); // Soft amber for info panels

  // Neutral palette
  static const dark        = Color(0xFF0A1628);
  static const textPrimary = Color(0xFF1A2332);
  static const textSecondary = Color(0xFF6B7A8D);
  static const bgLight     = Color(0xFFF5F7F6);
  static const white       = Color(0xFFFFFFFF);
  static const cardBorder  = Color(0xFFE0E7E5);
  static const success     = Color(0xFF2E7D32);
  static const successBg   = Color(0xFFE8F5E9);
}

class TummaTheme {
  // 24dp border radius used consistently across all cards
  static const double cardRadius = 24.0;
  static const double buttonRadius = 14.0;

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: TummaColors.bgLight,

    // Seed the colour scheme from our primary teal
    colorScheme: ColorScheme.fromSeed(
      seedColor: TummaColors.teal,
      primary: TummaColors.teal,
      secondary: TummaColors.amber,
    ),

    // Inter as the primary font across the whole app
    textTheme: GoogleFonts.interTextTheme().copyWith(
      displayLarge: GoogleFonts.inter(
        fontSize: 32, fontWeight: FontWeight.w800,
        color: TummaColors.textPrimary, letterSpacing: -1,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 22, fontWeight: FontWeight.w700,
        color: TummaColors.textPrimary, letterSpacing: -0.5,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 17, fontWeight: FontWeight.w700,
        color: TummaColors.textPrimary,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 15, color: TummaColors.textSecondary, height: 1.6,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 13, color: TummaColors.textSecondary,
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: TummaColors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: const IconThemeData(color: TummaColors.textPrimary),
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18, fontWeight: FontWeight.w700,
        color: TummaColors.textPrimary,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: TummaColors.teal,
        foregroundColor: TummaColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16, fontWeight: FontWeight.w700,
        ),
      ),
    ),

    cardTheme: CardTheme(
      color: TummaColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cardRadius),
        side: const BorderSide(color: TummaColors.cardBorder),
      ),
    ),
  );
}
