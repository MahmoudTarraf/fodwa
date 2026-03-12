import 'package:flutter/material.dart';
import 'package:fodwa/config/routes/app_router.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_constants.dart';

class GuestRestrictedScreen extends StatelessWidget {
  const GuestRestrictedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConstants.initSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Restricted Access',
          style: TextStyle(
            color: Colors.black,
            fontSize: AppConstants.w * 0.048,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.w * 0.06),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
              size: AppConstants.w * 0.25,
              color: const Color(0xFFBFC6CC),
            ),
            SizedBox(height: AppConstants.h * 0.03),
            Text(
              'Login or Sign Up to access this feature',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppConstants.w * 0.045,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF171725),
              ),
            ),
            SizedBox(height: AppConstants.h * 0.05),
            SizedBox(
              width: double.infinity,
              height: AppConstants.h * 0.0616,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.w * 0.0213),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppConstants.w * 0.0427,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppConstants.h * 0.02),
            SizedBox(
              width: double.infinity,
              height: AppConstants.h * 0.0616,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.signUp);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primaryColor, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.w * 0.0213),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: AppConstants.w * 0.0427,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
