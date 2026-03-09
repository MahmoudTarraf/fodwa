import 'package:fodwa/core/config/env_config.dart';

class AppEndPoints {
  static const String register = "signup/";
  static const String login = "login/";
  static const String addTrip = "trips/";
  static const String profile = "profile/";
  static const String vehicles = "vehicles/";
  static const String logout = "logout/";
  static const String updateProfile = 'profile/update/';

  static const String forget_pass = "forgot-password/";
  static const String verify_code = "verify-code/";
  static const String reset_password = "reset-password/";
  static const String resend_email = "resend-email-verification/";
  static const String verify_email_otp = "verify-email-otp/";

  // Lookups
  static const String countries = "lookups/countries/";
  static const String cities =
      "lookups/cities/"; // Needs suffix /{country_code}/
  static const String jobs = "lookups/jobs/";
  static const String sectors = "lookups/sectors/";
  static const String services = "lookups/services/";
  static const String skills = "lookups/skills/";
  static const String specializations = "lookups/specializations/";

  // Files
  static const String profileImage = "files/profile-image/";
  static const String bannerImage = "files/banner-image/";

  // Social
  static const String googleLogin = "google-login/";
  static const String appleLogin = "apple-login/";

  static const String trips = "trips/";
  static String get google_api_key => EnvConfig.googleApiKey;
  static String get placesBaseUrl => EnvConfig.placesBaseUrl;
}
