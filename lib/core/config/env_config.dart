import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get paymobBaseUrl => dotenv.env['PAYMOB_BASE_URL'] ?? '';
  static String get googleApiKey => dotenv.env['GOOGLE_API_KEY'] ?? '';
  static String get placesBaseUrl => dotenv.env['PLACES_BASE_URL'] ?? '';
  static int get paymobAppId => int.tryParse(dotenv.env['PAYMOB_APP_ID'] ?? '0') ?? 0;
  static String get paymobAppSign => dotenv.env['PAYMOB_APP_SIGN'] ?? '';
  static String get oneSignalAppId => dotenv.env['ONESIGNAL_APP_ID'] ?? '';
  static String get oneSignalApiKey => dotenv.env['ONESIGNAL_API_KEY'] ?? '';
}
