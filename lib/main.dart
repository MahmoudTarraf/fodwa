import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

import 'config/routes/app_router.dart';
import 'core/intialization/initiDI.dart';
import 'core/session/session_manager.dart';
import 'core/apiManager/dio_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  await EasyLocalization.ensureInitialized();
  await initDI();
  await DioClient.init();

  // Check if user is logged in
  final bool isLoggedIn = await SessionManager.isLoggedIn();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      startLocale: Locale("en"),

      fallbackLocale: const Locale('en'),
      child: MyApp(isLoggedIn: isLoggedIn),

      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) =>  MyApp(isLoggedIn: isLoggedIn)),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? AppRoutes.bottomNav : AppRoutes.splash,
      onGenerateRoute: (settings) => Routes.onGenerate(settings),
    );
  }
}
