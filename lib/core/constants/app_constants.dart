/// Application-wide constants
class AppConstants {
  AppConstants._();

  // API Configuration
  static const String apiBaseUrl = 'https://api.vendart.com';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Database
  static const String databaseName = 'vendart.db';

  // Cache
  static const Duration cacheValidDuration = Duration(hours: 1);
}
