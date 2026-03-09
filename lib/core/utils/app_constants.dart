
import 'package:flutter/cupertino.dart';
import 'package:fodwa/core/config/env_config.dart';

class AppConstants {
  @Deprecated('Use ResponsiveHelper.height instead')
  static late double h;

  @Deprecated('Use ResponsiveHelper.width instead')
  static late double w;

  static void initSize(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
  }

  //375 //812

  static String get base_url => EnvConfig.paymobBaseUrl;
  static const String auth_taken_enpoint = "/auth/tokens";
  static const String order_id_enpoint = "/ecommerce/orders";
  static const String oneSignalAPIURL =
      "https://onesignal.com/api/v1/notifications";

  static int get appId => EnvConfig.paymobAppId;
  static String get appSign => EnvConfig.paymobAppSign;
  static String get oneSignalAppId => EnvConfig.oneSignalAppId;
  static String get oneSignalApiKey => EnvConfig.oneSignalApiKey;
  static const String imageUrl = "assets/images/";
  static const String iconsUrl = "assets/icons/";
}

class StaticList {
  static final List<String> sections = [
    'الصف الرابع الابتدائي',
    'الصف الخامس الابتدائي',
    'الصف السادس الابتدائي',
    'الصف الأول الإعدادي',
    'الصف الثاني الإعدادي',
    'الصف الثالث الإعدادي',
    'الصف الأول الثانوي',
    'الصف الثاني الثانوي',
  ];
  static const List<String> supportedCountries = [
    'SA',
    'EG',
    'AE',
    'KW',
    'QA',
    'BH',
    'OM',
    'JO',
    'LB',
    'IQ',
    'PS',
    'SY',
    'YE',
    'MA',
    'DZ',
    'TN',
    'LY',
    'SD',
    'US',
    'GB',
    'CA',
    'AU',
    'DE',
    'FR',
    'IT',
    'ES',
    'TR',
    'IN',
    'PK',
    'BD',
    'CN',
    'JP',
    'KR',
  ];

  static final List<String> roles = ["General manager", "FM"];
}
