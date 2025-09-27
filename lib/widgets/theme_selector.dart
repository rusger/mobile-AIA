import 'package:flutter/material.dart';
import '../core/theme/color_schemes.dart';

class ThemeSelector extends StatelessWidget {
  final Function(AppColorScheme) onThemeChanged;
  
  const ThemeSelector({
    super.key,
    required this.onThemeChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppColorScheme.values.length,
        itemBuilder: (context, index) {
          final scheme = AppColorScheme.values[index];
          final palette = ColorSchemes.schemes[scheme]!;
          final isSelected = ColorSchemes.current == scheme;
          
          return GestureDetector(
            onTap: () => onThemeChanged(scheme),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: palette.buttonGradient,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  palette.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
