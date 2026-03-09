// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fodwa/config/routes/app_router.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/app_texts.dart';
import 'package:fodwa/core/utils/app_images.dart';
import 'package:fodwa/generated/locale_keys.g.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/forget_pass/forget_email_pass.dart';

Widget welcom_login_text() {
  return Text(
    LocaleKeys.auth_welcomeBack.tr(),
    style: AppTextStyles.displayMedium().copyWith(
      fontSize: AppConstants.w * 0.059,
    ),
  );
}

Widget welcom_login_sub_headline() {
  return Text(
    LocaleKeys.auth_enterInfoToAccess.tr(),
    style: AppTextStyles.titleMedium().copyWith(
      color: const Color(0xFF9CA4AB),
      fontSize: AppConstants.w * 0.034,
    ),
  );
}

Widget build_field_name(String fieldName) {
  return Text(
    fieldName,
    textAlign: TextAlign.left,
    style: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: AppConstants.w * 0.037,
      letterSpacing: 0,
      color: const Color(0xFF171725),
    ),
  );
}

Widget build_remember() {
  return Text(
    LocaleKeys.auth_rememberMe.tr(),
    textAlign: TextAlign.left,
    style: AppTextStyles.titleMedium().copyWith(
      fontSize: AppConstants.w * 0.032,
      letterSpacing: 0.2,
      color: AppColors.blackPrimaryColor,
      fontWeight: FontWeight.w400,
    ),
  );
}

Widget build_forget_pass(
  BuildContext context, {
  required void Function(String email) onSend,
}) {
  return InkWell(
    onTap: () {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => ForgotPasswordDialog(
          onSubmit: (email) {
            Navigator.pop(context);
            onSend(email);
          },
        ),
      );
    },
    child: Text(
      LocaleKeys.auth_forgotPassword.tr(),
      textAlign: TextAlign.left,
      style: AppTextStyles.titleMedium().copyWith(
        fontSize: AppConstants.w * 0.032,
        letterSpacing: 0.2,
        color: const Color(0xFFF75555),
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

Widget guest_text(BuildContext context) {
  return Center(
    child: Container(
      width: AppConstants.w * 0.47,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.primaryColor, width: 1),
        ),
      ),
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.bottomNav);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.login,
                color: AppColors.primaryColor,
                width: AppConstants.w * 0.064,
              ),
              SizedBox(width: AppConstants.w * 0.014),
              Flexible(
                child: Text(
                  LocaleKeys.auth_continueAsGuest.tr(),
                  style: AppTextStyles.displaySmall().copyWith(
                    color: AppColors.primaryColor,
                    fontSize: AppConstants.w * 0.0418,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget dontHaveAccount({required VoidCallback onTap}) {
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
            text: "You don’t have an account? ",
            style: TextStyle(color: AppColors.blackPrimaryColor),
          ),
          TextSpan(
            text: "Sign up",
            style: TextStyle(color: AppColors.pColor),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    ),
  );
}

Widget build_or_text() {
  return Row(
    children: [
      Expanded(
        child: Divider(
          color: AppColors.dividerColor.withOpacity(0.5),
          thickness: 1.5,
          endIndent: AppConstants.w * 0.03,
        ),
      ),
      Text(
        LocaleKeys.auth_or.tr(),
        style: AppTextStyles.titleMedium().copyWith(
          fontSize: AppConstants.w * 0.032,
          fontWeight: FontWeight.w400,
        ),
      ),
      Expanded(
        child: Divider(
          color: AppColors.dividerColor.withOpacity(0.5),
          thickness: 1.5,
          indent: AppConstants.w * 0.03,
        ),
      ),
    ],
  );
}
