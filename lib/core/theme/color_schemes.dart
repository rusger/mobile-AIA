import 'package:flutter/material.dart';

enum AppColorScheme {
  cosmic,    // Original purple theme
  cyberpunk, // Cyan/neon tech theme
  mars,      // Red/orange Mars theme
  aurora,    // Green/blue northern lights
}

class ColorSchemes {
  static AppColorScheme current = AppColorScheme.cosmic;
  
  static Map<AppColorScheme, ColorPalette> schemes = {
    AppColorScheme.cosmic: ColorPalette(
      name: 'Cosmic',
      backgroundGradient: const [
        Color(0xFF1A0033),
        Color(0xFF2D1B4E),
        Color(0xFF402263),
      ],
      primaryAccent: Colors.purple.shade300,
      secondaryAccent: Colors.purple.shade400,
      tertiaryAccent: Colors.purple.shade700,
      buttonGradient: const [
        Color(0xFFFF6B9D),
        Color(0xFF9B59B6),
      ],
    ),
    AppColorScheme.cyberpunk: ColorPalette(
      name: 'Cyberpunk',
      backgroundGradient: const [
        Color(0xFF000428),
        Color(0xFF004e92),
        Color(0xFF1a0033),
      ],
      primaryAccent: Colors.cyan.shade300,
      secondaryAccent: const Color(0xFF00DDDD),
      tertiaryAccent: const Color(0xFF004e92),
      buttonGradient: const [
        Color(0xFF00FFFF),
        Color(0xFF7B2FFF),
      ],
    ),
    AppColorScheme.mars: ColorPalette(
      name: 'Mars Colony',
      backgroundGradient: const [
        Color(0xFF2E0A0A),
        Color(0xFF8B2500),
        Color(0xFF4A1C1C),
      ],
      primaryAccent: Colors.orange.shade300,
      secondaryAccent: Colors.deepOrange.shade400,
      tertiaryAccent: Colors.red.shade900,
      buttonGradient: const [
        Color(0xFFFF6B35),
        Color(0xFFFF9558),
      ],
    ),
    AppColorScheme.aurora: ColorPalette(
      name: 'Aurora',
      backgroundGradient: const [
        Color(0xFF001220),
        Color(0xFF003F5C),
        Color(0xFF2C5F2D),
      ],
      primaryAccent: Colors.teal.shade300,
      secondaryAccent: Colors.green.shade400,
      tertiaryAccent: Colors.teal.shade700,
      buttonGradient: const [
        Color(0xFF00FFA3),
        Color(0xFF03DAC6),
      ],
    ),
  };
  
  static ColorPalette get colors => schemes[current]!;
}

class ColorPalette {
  final String name;
  final List<Color> backgroundGradient;
  final Color primaryAccent;
  final Color secondaryAccent;
  final Color tertiaryAccent;
  final List<Color> buttonGradient;
  
  ColorPalette({
    required this.name,
    required this.backgroundGradient,
    required this.primaryAccent,
    required this.secondaryAccent,
    required this.tertiaryAccent,
    required this.buttonGradient,
  });
}
