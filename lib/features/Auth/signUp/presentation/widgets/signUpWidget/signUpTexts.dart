import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fodwa/config/routes/app_router.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_texts.dart';
import '../../../../../../core/utils/app_constants.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sign Up to FODWA',
          style: AppTextStyles.headlineLarge().copyWith(
            color: AppColors.pColor,
            letterSpacing: 0.2,
            fontWeight: FontWeight.w600,
            fontSize: AppConstants.w * 0.048, // 18px / 375
          ),
        ),
        SizedBox(
          height: AppConstants.h * 0.008, // 7px / 812
        ),
        Text(
          'Enter your details below',
          style: TextStyle(
            color: const Color(0xFF9CA4AB),
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
            fontSize: AppConstants.w * 0.037, // 14px / 375
          ),
        ),
      ],
    );
  }
}

Widget build_policy() {
  return FittedBox(
    fit: BoxFit.scaleDown,
    alignment: Alignment.centerLeft,
    child: Row(
      children: [
        Text(
          "I agree to the",
          style: AppTextStyles.titleMedium().copyWith(
            fontSize: AppConstants.w * 0.032,
            color: const Color(0XFF212121),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 4),
        underlineText("Term condition"),
        Text(
          ' & ',
          style: AppTextStyles.titleMedium().copyWith(
            fontSize: AppConstants.w * 0.032,
            color: const Color(0XFF212121),
            fontWeight: FontWeight.w400,
          ),
        ),
        underlineText("Privacy policy"),
      ],
    ),
  );
}

Widget underlineText(String text) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        text,
        style: AppTextStyles.titleMedium().copyWith(
          fontSize: AppConstants.w * 0.032,
          color: AppColors.pColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      Container(
        height: AppConstants.h * 0.0009,
        width: text.length * AppConstants.w * 0.012,
        color: AppColors.pColor,
      ),
    ],
  );
}

Widget haveAccount({
  required VoidCallback onTap,
  required BuildContext context,
}) {
  return Center(
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTextStyles.headlineLarge().copyWith(
          letterSpacing: 0.2,
          fontWeight: FontWeight.w600,
          fontSize: AppConstants.w * 0.0427,
        ),
        children: [
          TextSpan(
            text: "You have an account? ",
            style: TextStyle(color: AppColors.blackPrimaryColor),
          ),
          TextSpan(
            text: "Log in",
            style: TextStyle(color: AppColors.pColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, AppRoutes.login);
              },
          ),
        ],
      ),
    ),
  );
}
