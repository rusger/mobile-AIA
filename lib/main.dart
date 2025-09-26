import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';
import 'l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const AIAstrologApp());
}

class AIAstrologApp extends StatefulWidget {
  const AIAstrologApp({super.key});

  @override
  State<AIAstrologApp> createState() => _AIAstrologAppState();
  
  static void setLocale(BuildContext context, Locale newLocale) {
    _AIAstrologAppState? state = context.findAncestorStateOfType<_AIAstrologAppState>();
    state?.setLocale(newLocale);
  }
}

class _AIAstrologAppState extends State<AIAstrologApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    _getLocale().then((locale) => setLocale(locale));
    super.didChangeDependencies();
  }

  _getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('language_code') ?? 'en';
    String countryCode = prefs.getString('country_code') ?? 'US';
    return Locale(languageCode, countryCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Astrolog',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      locale: _locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SplashScreen(),
    );
  }
}