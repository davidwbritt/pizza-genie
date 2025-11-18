import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  /// Light theme configuration with Italian design
  static ThemeData get lightTheme {
    // Italian flag colors - green as primary for sophistication
    const italianRed = Color(0xFFC8102E);
    const italianGreen = Color(0xFF009246);
    const warmCrustBrown = Color(0xFFF4E4B8); // Warm brown crust color from splash
    const creamyWhite = Color(0xFFF8F6F0);
    
    final colorScheme = ColorScheme.light(
      primary: italianGreen,
      secondary: italianRed,
      surface: warmCrustBrown,
      surfaceVariant: creamyWhite,
      primaryContainer: italianGreen.withOpacity(0.1),
      secondaryContainer: italianRed.withOpacity(0.1),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: const Color(0xFF2C1810),
      onSurfaceVariant: const Color(0xFF5D4037),
      outline: const Color(0xFFBCAAA4),
      shadow: Colors.black26,
    );
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      
      // Premium typography with Italian elegance
      textTheme: GoogleFonts.interTextTheme().copyWith(
        // Headers use elegant serif for sophistication
        headlineLarge: GoogleFonts.playfairDisplay(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
          letterSpacing: -0.5,
        ),
        headlineSmall: GoogleFonts.playfairDisplay(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        
        // Body text uses clean Inter for readability
        titleLarge: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
          letterSpacing: -0.2,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurfaceVariant,
        ),
        
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
          height: 1.4,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurfaceVariant,
          height: 1.4,
        ),
        
        // Labels and UI elements
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
          letterSpacing: 0.1,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurfaceVariant,
          letterSpacing: 0.5,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurfaceVariant,
          letterSpacing: 0.5,
        ),
      ),
      
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
          elevation: 2,
          shadowColor: colorScheme.shadow,
        ),
      ),
      
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 1,
        shadowColor: colorScheme.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        filled: true,
        fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
        contentPadding: const EdgeInsets.all(16),
        labelStyle: GoogleFonts.inter(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  /// Dark theme configuration with Italian design
  static ThemeData get darkTheme {
    // Italian flag colors adapted for dark theme - green primary
    const italianRedDark = Color(0xFFE53E3E);
    const italianGreenDark = Color(0xFF38A169);
    const darkCrustBrown = Color(0xFF8B6914); // Darker version of crust brown
    const darkSurfaceVariant = Color(0xFF2D2D2D);
    
    final colorScheme = ColorScheme.dark(
      primary: italianGreenDark,
      secondary: italianRedDark,
      surface: darkCrustBrown,
      surfaceVariant: darkSurfaceVariant,
      primaryContainer: italianGreenDark.withOpacity(0.2),
      secondaryContainer: italianRedDark.withOpacity(0.2),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: const Color(0xFFE5E5E5),
      onSurfaceVariant: const Color(0xFFB3B3B3),
      outline: const Color(0xFF616161),
      shadow: Colors.black54,
    );
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      
      // Same typography system with dark theme colors
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        headlineLarge: GoogleFonts.playfairDisplay(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
          letterSpacing: -0.5,
        ),
        headlineSmall: GoogleFonts.playfairDisplay(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
          letterSpacing: -0.2,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurfaceVariant,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
          height: 1.4,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurfaceVariant,
          height: 1.4,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
          letterSpacing: 0.1,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurfaceVariant,
          letterSpacing: 0.5,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurfaceVariant,
          letterSpacing: 0.5,
        ),
      ),
      
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),
      
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
          elevation: 2,
          shadowColor: colorScheme.shadow,
        ),
      ),
      
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 1,
        shadowColor: colorScheme.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        filled: true,
        fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
        contentPadding: const EdgeInsets.all(16),
        labelStyle: GoogleFonts.inter(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}