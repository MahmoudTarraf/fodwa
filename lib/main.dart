import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

import 'config/routes/app_router.dart';
import 'core/intialization/initiDI.dart';
import 'core/apiManager/dio_client.dart';
import 'core/networkError/network_state_wrapper.dart';
import 'core/utils/navigator_key.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  await EasyLocalization.ensureInitialized();
  await initDI();
  await DioClient.init();

  // Initialization finished
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      startLocale: Locale("en"),

      fallbackLocale: const Locale('en'),
      child: const MyApp(),

      // DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) =>  MyApp(isLoggedIn: isLoggedIn)),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: (settings) => Routes.onGenerate(settings),
      builder: (context, child) {
        return NetworkStateWrapper(child: child!);
      },
    );
  }
}
