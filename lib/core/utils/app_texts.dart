import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_constants.dart';

class AppTextStyles {
  static final Color textPrimary = AppColors.textPrimary;
  static const Color textSecondary = AppColors.textSecondary;

  static TextStyle displayMedium() => TextStyle(
    fontSize: AppConstants.w * 0.053, // 20 / 375
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    color: AppColors.blackPrimaryColor,
    height: 1.3,
  );

  static TextStyle displaySmall() => TextStyle(
    fontSize: AppConstants.w * 0.037, // 14 / 375
    fontWeight: FontWeight.w500,
    color: AppColors.blackPrimaryColor,
    height: 1.3,
  );

  static TextStyle titleMedium() => TextStyle(
    fontSize: AppConstants.w * 0.032, // 12 / 375
    fontWeight: FontWeight.w500,
    color: textPrimary,
    letterSpacing: 0,
    height: 1.5,
  );

  static TextStyle labelMedium() => TextStyle(
    fontSize: AppConstants.w * 0.027, // 10 / 375
    fontWeight: FontWeight.w500,
    color: textPrimary,
    letterSpacing: 0.5,
    height: 1.4,
  );

  static TextStyle displayLarge() => TextStyle(
    fontSize: AppConstants.w * 0.064, // 24 / 375
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    color: textPrimary,
    height: 1.2,
  );

  static TextStyle headlineLarge() => TextStyle(
    fontSize: AppConstants.w * 0.043, // 16 / 375
    fontWeight: FontWeight.w500,
    color: textPrimary,
    height: 1.4,
  );

  static TextStyle headlineMedium() => TextStyle(
    fontSize: AppConstants.w * 0.04, // 15 / 375
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.4,
  );

  static TextStyle headlineSmall() => TextStyle(
    fontSize: AppConstants.w * 0.037, // 14 / 375
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.4,
  );

  static TextStyle titleLarge() => TextStyle(
    fontSize: AppConstants.w * 0.035, // 13 / 375
    fontWeight: FontWeight.w600,
    color: textPrimary,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static TextStyle bodyLarge() => TextStyle(
    fontSize: AppConstants.w * 0.035, // 13 / 375
    fontWeight: FontWeight.w400,
    color: textPrimary,
    letterSpacing: 0.5,
    height: 1.5,
  );

  static TextStyle bodyMedium() => TextStyle(
    fontSize: AppConstants.w * 0.032, // 12 / 375
    fontWeight: FontWeight.w400,
    color: textPrimary,
    letterSpacing: 0.25,
    height: 1.5,
  );

  static TextStyle bodySmall() => TextStyle(
    fontSize: AppConstants.w * 0.027, // 10 / 375
    fontWeight: FontWeight.w400,
    color: textSecondary,
    letterSpacing: 0.4,
    height: 1.5,
  );

  static TextStyle labelLarge() => TextStyle(
    fontSize: AppConstants.w * 0.032, // 12 / 375
    fontWeight: FontWeight.w500,
    color: textPrimary,
    letterSpacing: 0.1,
    height: 1.4,
  );
}
