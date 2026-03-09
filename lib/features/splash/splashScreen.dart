import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_images.dart';
import 'package:fodwa/features/Auth/login/presentation/pages/login_screen.dart';
import '../../core/utils/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  void _navigateAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    AppConstants.initSize(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: buildContent(),
    );
  }

  Widget buildContent() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: AppConstants.h * 0.18),

          /// Logo Name
          Image.asset(
            AppImages.fodwaName,
            width: AppConstants.w * 0.787,
            height: AppConstants.h * 0.114,
            fit: BoxFit.contain,
          ),

          SizedBox(height: AppConstants.h * 0.112),

          /// Logo Icon
          Image.asset(
            AppImages.logo,
            width: AppConstants.w * 0.323,
            height: AppConstants.h * 0.149,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
