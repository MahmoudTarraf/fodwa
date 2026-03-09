import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/app_images.dart' show AppImages;
import 'package:fodwa/core/utils/app_texts.dart';

class ForgetHeader extends StatelessWidget {
  const ForgetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppImages.logo,
                  width: AppConstants.w * 0.104,
                  height: AppConstants.h * 0.047,
                ),
                SizedBox(width: AppConstants.w * 0.032),
                Image.asset(
                  AppImages.fodwaName,
                  width: AppConstants.w * 0.219,
                  height: AppConstants.h * 0.032,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CloseWidgetButton(onTap: () => Navigator.pop(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CloseWidgetButton extends StatelessWidget {
  final VoidCallback onTap;

  const CloseWidgetButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.w * 0.053),
      child: Container(
        width: AppConstants.w * 0.064,
        height: AppConstants.w * 0.064,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primaryColor, width: 1.5),
        ),
        child: const Icon(Icons.close, color: AppColors.primaryColor, size: 14),
      ),
    );
  }
}

class ForgetTitle extends StatelessWidget {
  final String? title;
  final String? description;

  const ForgetTitle({super.key, this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? 'Forgot Password',
          style: AppTextStyles.displayMedium().copyWith(
            color: AppColors.pColor,
            fontSize: AppConstants.w * 0.048,
          ),
        ),
        SizedBox(height: AppConstants.h * 0.009),
        Text(
          description ?? 'Enter your email to get a reset code.',
          style: AppTextStyles.displaySmall().copyWith(
            color: const Color(0xFF66707A),
          ),
        ),
      ],
    );
  }
}
