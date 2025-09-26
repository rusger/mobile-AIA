import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  
  AppLocalizations(this.locale);
  
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
  
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
  
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('es', 'ES'),
    Locale('fr', 'FR'),
    Locale('de', 'DE'),
    Locale('it', 'IT'),
    Locale('pt', 'PT'),
    Locale('ru', 'RU'),
    Locale('zh', 'CN'),
    Locale('ja', 'JP'),
    Locale('ko', 'KR'),
    Locale('hi', 'IN'),
    Locale('ar', 'SA'),
  ];
  
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'start_new': 'Start New',
      'select_language': 'Select Your Language',
      'continue': 'Continue',
      'welcome': 'Welcome to AI Astrolog',
      'enter_birth_info': 'Enter Your Birth Information',
      'date_of_birth': 'Date of Birth',
      'time_of_birth': 'Time of Birth',
      'place_of_birth': 'Place of Birth',
      'select_date': 'Select Date',
      'select_time': 'Select Time',
      'search_city': 'Search for city...',
      'next': 'Next',
      'back': 'Back',
      'submit': 'Submit',
    },
    'es': {
      'start_new': 'Comenzar',
      'select_language': 'Selecciona tu idioma',
      'continue': 'Continuar',
      'welcome': 'Bienvenido a AI Astrolog',
      'enter_birth_info': 'Ingresa tu información de nacimiento',
      'date_of_birth': 'Fecha de nacimiento',
      'time_of_birth': 'Hora de nacimiento',
      'place_of_birth': 'Lugar de nacimiento',
      'select_date': 'Seleccionar fecha',
      'select_time': 'Seleccionar hora',
      'search_city': 'Buscar ciudad...',
      'next': 'Siguiente',
      'back': 'Atrás',
      'submit': 'Enviar',
    },
    'fr': {
      'start_new': 'Commencer',
      'select_language': 'Sélectionnez votre langue',
      'continue': 'Continuer',
      'welcome': 'Bienvenue à AI Astrolog',
      'enter_birth_info': 'Entrez vos informations de naissance',
      'date_of_birth': 'Date de naissance',
      'time_of_birth': 'Heure de naissance',
      'place_of_birth': 'Lieu de naissance',
      'select_date': 'Sélectionner la date',
      'select_time': 'Sélectionner l\'heure',
      'search_city': 'Rechercher une ville...',
      'next': 'Suivant',
      'back': 'Retour',
      'submit': 'Soumettre',
    },
  };
  
  String get startNew => _localizedValues[locale.languageCode]?['start_new'] ?? _localizedValues['en']!['start_new']!;
  String get selectLanguage => _localizedValues[locale.languageCode]?['select_language'] ?? _localizedValues['en']!['select_language']!;
  String get continueText => _localizedValues[locale.languageCode]?['continue'] ?? _localizedValues['en']!['continue']!;
  String get welcome => _localizedValues[locale.languageCode]?['welcome'] ?? _localizedValues['en']!['welcome']!;
  String get enterBirthInfo => _localizedValues[locale.languageCode]?['enter_birth_info'] ?? _localizedValues['en']!['enter_birth_info']!;
  String get dateOfBirth => _localizedValues[locale.languageCode]?['date_of_birth'] ?? _localizedValues['en']!['date_of_birth']!;
  String get timeOfBirth => _localizedValues[locale.languageCode]?['time_of_birth'] ?? _localizedValues['en']!['time_of_birth']!;
  String get placeOfBirth => _localizedValues[locale.languageCode]?['place_of_birth'] ?? _localizedValues['en']!['place_of_birth']!;
  String get selectDate => _localizedValues[locale.languageCode]?['select_date'] ?? _localizedValues['en']!['select_date']!;
  String get selectTime => _localizedValues[locale.languageCode]?['select_time'] ?? _localizedValues['en']!['select_time']!;
  String get searchCity => _localizedValues[locale.languageCode]?['search_city'] ?? _localizedValues['en']!['search_city']!;
  String get next => _localizedValues[locale.languageCode]?['next'] ?? _localizedValues['en']!['next']!;
  String get back => _localizedValues[locale.languageCode]?['back'] ?? _localizedValues['en']!['back']!;
  String get submit => _localizedValues[locale.languageCode]?['submit'] ?? _localizedValues['en']!['submit']!;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  
  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'fr', 'de', 'it', 'pt', 'ru', 'zh', 'ja', 'ko', 'hi', 'ar']
        .contains(locale.languageCode);
  }
  
  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }
  
  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
