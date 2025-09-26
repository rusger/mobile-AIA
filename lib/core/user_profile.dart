class UserProfile {
  final DateTime dateOfBirth;
  final DateTime timeOfBirth;
  final String placeOfBirth;
  final double latitude;
  final double longitude;
  final String timezone;
  final String languageCode;
  
  UserProfile({
    required this.dateOfBirth,
    required this.timeOfBirth,
    required this.placeOfBirth,
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.languageCode,
  });
  
  Map<String, dynamic> toJson() => {
    'dateOfBirth': dateOfBirth.toIso8601String(),
    'timeOfBirth': timeOfBirth.toIso8601String(),
    'placeOfBirth': placeOfBirth,
    'latitude': latitude,
    'longitude': longitude,
    'timezone': timezone,
    'languageCode': languageCode,
  };
  
  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    dateOfBirth: DateTime.parse(json['dateOfBirth']),
    timeOfBirth: DateTime.parse(json['timeOfBirth']),
    placeOfBirth: json['placeOfBirth'],
    latitude: json['latitude'],
    longitude: json['longitude'],
    timezone: json['timezone'],
    languageCode: json['languageCode'],
  );
}
