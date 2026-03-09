import 'package:flutter/material.dart';
import 'package:fodwa/features/helpAndSupport/presentation/pages/help_support.dart';
import 'package:fodwa/features/home/presentation/pages/home_page_item.dart';
import 'package:fodwa/features/Auth/login/presentation/pages/login_screen.dart';
import 'package:fodwa/features/Auth/signUp/presentation/pages/sign_up_screen.dart';
import 'package:fodwa/features/bottom_nav/bottom_nav.dart';
import 'package:fodwa/features/splash/splashScreen.dart';
import 'package:fodwa/features/profile/presentation/pages/edit_profile_screen.dart';
import 'package:fodwa/features/profile/presentation/widgets/myAddress/add_new_address.dart';

class AppRoutes {
  static const String homePage = "/homePage";
  static const String bottomNav = "/home";
  static const String profile = "/profile";
  static const String signUp = "/signUp";
  static const String add_load = "/add_load";
  static const String login = "/login";
  static const String onBoard = "/onboard";
  static const String help = "/helpAndSupport";
  static const String problems = "/problems";
  static const String forgetPassword = "/forgetPassword";
  static const String notification = "/notification";
  static const String autoLogin = "/autoLogin";
  static const String splash = "/";
  static const String lectures = "/lectures";
  static const String supportCallWidget = "/supportCallWidget";
  static const String addLoadScreen = "addLoadScreen/";
  static const String loadDetailsScreen = "LoadDetailsScreen/";
  static const String editProfile = "editProfile/";
  static const String addNewAddress = "addNewAddress/";
}

class Routes {
  static onGenerate(RouteSettings setting) {
    switch (setting.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case AppRoutes.help:
        return MaterialPageRoute(builder: (context) => const HelpAndSupport());
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case AppRoutes.homePage:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case AppRoutes.bottomNav:
        return MaterialPageRoute(builder: (context) => const BottomNav());
      case AppRoutes.editProfile:
        return MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        );
        case AppRoutes.addNewAddress:
        return MaterialPageRoute(
          builder: (context) => const AddNewAddress(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(title: const Text("error")),
              body: unDefinedRoute(),
            );
          },
        );
    }
  }

  static Widget unDefinedRoute() {
    return const Center(child: Text("Route Not Found"));
  }
}
