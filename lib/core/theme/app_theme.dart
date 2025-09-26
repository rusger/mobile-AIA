import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme => _buildTheme(Brightness.light);
  static ThemeData get darkTheme => _buildTheme(Brightness.dark);
  
  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    
    return ThemeData(
      brightness: brightness,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6B5B95),
        brightness: brightness,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData(brightness: brightness).textTheme,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
  
  static const List<Color> backgroundGradientLight = [
    Color(0xFFE8D5F2),
    Color(0xFFBAA7E7),
    Color(0xFF8B78DB),
  ];
  
  static const List<Color> backgroundGradientDark = [
    Color(0xFF1A0033),
    Color(0xFF2D1B4E),
    Color(0xFF402263),
  ];
  
  static const List<Color> accentGradient = [
    Color(0xFFFF6B9D),
    Color(0xFFFECA57),
    Color(0xFF66D9EF),
  ];
}
