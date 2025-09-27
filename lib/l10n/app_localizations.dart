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
    'de': {
      'start_new': 'Neu starten',
      'select_language': 'Wählen Sie Ihre Sprache',
      'continue': 'Weiter',
      'welcome': 'Willkommen bei AI Astrolog',
      'enter_birth_info': 'Geben Sie Ihre Geburtsinformationen ein',
      'date_of_birth': 'Geburtsdatum',
      'time_of_birth': 'Geburtszeit',
      'place_of_birth': 'Geburtsort',
      'select_date': 'Datum auswählen',
      'select_time': 'Zeit auswählen',
      'search_city': 'Nach Stadt suchen...',
      'next': 'Weiter',
      'back': 'Zurück',
      'submit': 'Absenden',
    },
    'it': {
      'start_new': 'Inizia',
      'select_language': 'Seleziona la tua lingua',
      'continue': 'Continua',
      'welcome': 'Benvenuto in AI Astrolog',
      'enter_birth_info': 'Inserisci le tue informazioni di nascita',
      'date_of_birth': 'Data di nascita',
      'time_of_birth': 'Ora di nascita',
      'place_of_birth': 'Luogo di nascita',
      'select_date': 'Seleziona data',
      'select_time': 'Seleziona ora',
      'search_city': 'Cerca città...',
      'next': 'Avanti',
      'back': 'Indietro',
      'submit': 'Invia',
    },
    'pt': {
      'start_new': 'Iniciar',
      'select_language': 'Selecione seu idioma',
      'continue': 'Continuar',
      'welcome': 'Bem-vindo ao AI Astrolog',
      'enter_birth_info': 'Insira suas informações de nascimento',
      'date_of_birth': 'Data de nascimento',
      'time_of_birth': 'Hora de nascimento',
      'place_of_birth': 'Local de nascimento',
      'select_date': 'Selecionar data',
      'select_time': 'Selecionar hora',
      'search_city': 'Procurar cidade...',
      'next': 'Próximo',
      'back': 'Voltar',
      'submit': 'Enviar',
    },
    'ru': {
      'start_new': 'Начать',
      'select_language': 'Выберите ваш язык',
      'continue': 'Продолжить',
      'welcome': 'Добро пожаловать в AI Astrolog',
      'enter_birth_info': 'Введите информацию о рождении',
      'date_of_birth': 'Дата рождения',
      'time_of_birth': 'Время рождения',
      'place_of_birth': 'Место рождения',
      'select_date': 'Выбрать дату',
      'select_time': 'Выбрать время',
      'search_city': 'Искать город...',
      'next': 'Далее',
      'back': 'Назад',
      'submit': 'Отправить',
    },
    'zh': {
      'start_new': '开始',
      'select_language': '选择您的语言',
      'continue': '继续',
      'welcome': '欢迎使用 AI Astrolog',
      'enter_birth_info': '输入您的出生信息',
      'date_of_birth': '出生日期',
      'time_of_birth': '出生时间',
      'place_of_birth': '出生地点',
      'select_date': '选择日期',
      'select_time': '选择时间',
      'search_city': '搜索城市...',
      'next': '下一步',
      'back': '返回',
      'submit': '提交',
    },
    'ja': {
      'start_new': '開始',
      'select_language': '言語を選択してください',
      'continue': '続ける',
      'welcome': 'AI Astrologへようこそ',
      'enter_birth_info': '生年月日情報を入力してください',
      'date_of_birth': '生年月日',
      'time_of_birth': '出生時刻',
      'place_of_birth': '出生地',
      'select_date': '日付を選択',
      'select_time': '時刻を選択',
      'search_city': '都市を検索...',
      'next': '次へ',
      'back': '戻る',
      'submit': '送信',
    },
    'ko': {
      'start_new': '시작',
      'select_language': '언어를 선택하세요',
      'continue': '계속',
      'welcome': 'AI Astrolog에 오신 것을 환영합니다',
      'enter_birth_info': '출생 정보를 입력하세요',
      'date_of_birth': '생년월일',
      'time_of_birth': '출생 시간',
      'place_of_birth': '출생지',
      'select_date': '날짜 선택',
      'select_time': '시간 선택',
      'search_city': '도시 검색...',
      'next': '다음',
      'back': '뒤로',
      'submit': '제출',
    },
    'hi': {
      'start_new': 'शुरू करें',
      'select_language': 'अपनी भाषा चुनें',
      'continue': 'जारी रखें',
      'welcome': 'AI Astrolog में आपका स्वागत है',
      'enter_birth_info': 'अपनी जन्म जानकारी दर्ज करें',
      'date_of_birth': 'जन्म तिथि',
      'time_of_birth': 'जन्म समय',
      'place_of_birth': 'जन्म स्थान',
      'select_date': 'तारीख चुनें',
      'select_time': 'समय चुनें',
      'search_city': 'शहर खोजें...',
      'next': 'अगला',
      'back': 'वापस',
      'submit': 'जमा करें',
    },
    'ar': {
      'start_new': 'ابدأ',
      'select_language': 'اختر لغتك',
      'continue': 'استمر',
      'welcome': 'مرحباً بك في AI Astrolog',
      'enter_birth_info': 'أدخل معلومات ميلادك',
      'date_of_birth': 'تاريخ الميلاد',
      'time_of_birth': 'وقت الميلاد',
      'place_of_birth': 'مكان الميلاد',
      'select_date': 'اختر التاريخ',
      'select_time': 'اختر الوقت',
      'search_city': 'ابحث عن مدينة...',
      'next': 'التالي',
      'back': 'رجوع',
      'submit': 'إرسال',
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
