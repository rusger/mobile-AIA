import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../main.dart';
import '../widgets/gradient_background.dart';
// Removed glass_container import - using custom containers instead
import '../core/constants/app_constants.dart';
import '../l10n/app_localizations.dart';
import 'birth_info_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? selectedLanguage;
  
  Future<void> _setLanguage(String languageCode) async {
    HapticFeedback.lightImpact();
    setState(() {
      selectedLanguage = languageCode;
    });
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);
    
    if (mounted) {
      Locale newLocale = Locale(languageCode);
      AIAstrologApp.setLocale(context, newLocale);
      
      Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const BirthInfoScreen(),
            transitionsBuilder: (_, animation, __, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: child,
              );
            },
          ),
        );
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        l10n.selectLanguage,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: AppConstants.supportedLanguages.length,
                    itemBuilder: (context, index) {
                      final language = AppConstants.supportedLanguages[index];
                      final isSelected = selectedLanguage == language['code'];
                      
                      return InkWell(
                        onTap: () => _setLanguage(language['code']!),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(isSelected ? 0.2 : 0.1),
                            border: Border.all(
                              color: Colors.white.withOpacity(isSelected ? 0.5 : 0.2),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                language['flag']!,
                                style: const TextStyle(fontSize: 32),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                language['name']!,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.white70,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ).animate().scale(
                        delay: Duration(milliseconds: 50 * index),
                        duration: 400.ms,
                        curve: Curves.easeOutBack,
                      );
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
