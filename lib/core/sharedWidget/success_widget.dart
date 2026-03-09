// success_dialog.dart
import 'package:flutter/material.dart';
import 'package:fodwa/core/sharedWidget/larg_button.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_images.dart';

import '../../features/Auth/login/presentation/widgets/forget_pass/common.dart';
import '../utils/app_constants.dart';

class SuccessDialog extends StatelessWidget {
  final String headline;
  final String description;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final bool showButton;
  final VoidCallback? onClose;

  const SuccessDialog({
    super.key,
    required this.headline,
    required this.description,
    this.buttonText,
    this.onButtonPressed,
    this.showButton = true,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      /// 16 / 375
      insetPadding: EdgeInsets.symmetric(horizontal: AppConstants.w * 0.0427),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppConstants.w * 0.042, // 24 / 375
        ),
      ),
      backgroundColor: Colors.white,
      child: Container(
        /// 327 / 375
        width: AppConstants.w * 0.872,

        child: Padding(
          /// 16 / 375
          padding: EdgeInsets.all(AppConstants.w * 0.0427),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    /// ✅ Success Image
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        /// 75 / 375
                        width: AppConstants.w * 0.21,
                        height: AppConstants.w * 0.21,
                        child: Image.asset(
                          AppImages.success,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    /// ❌ Close Button
                    Align(
                      alignment: Alignment.topRight,
                      child: CloseWidgetButton(
                        onTap: onClose ?? () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),

                /// 16 / 812
                SizedBox(height: AppConstants.h * 0.019),

                /// Title
                Text(
                  'Congratulations!',
                  style: TextStyle(
                    /// 18 / 375
                    fontSize: AppConstants.w * 0.048,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Inter",
                    color: AppColors.primaryColor,
                  ),
                ),

                /// 8 / 812
                SizedBox(height: AppConstants.h * 0.011),

                /// Headline
                Text(
                  headline,
                  style: TextStyle(
                    /// 14 / 375
                    fontSize: AppConstants.w * 0.0373,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF171725),
                  ),
                  textAlign: TextAlign.center,
                ),

                /// 6 / 812
                SizedBox(height: AppConstants.h * 0.0074),

                /// Description
                Text(
                  description,
                  style: TextStyle(
                    /// 14 / 375
                    fontSize: AppConstants.w * 0.0373,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF66707A),
                  ),
                  textAlign: TextAlign.center,
                ),

                /// 12 / 812
                SizedBox(height: AppConstants.h * 0.015),

                /// Button
                if (showButton)
                  SizedBox(
                    width: double.infinity,
                    child: large_button(
                      onPressed:
                          onButtonPressed ??
                          () {
                            Navigator.pop(context);
                          },
                      buttonName: buttonText ?? 'Continue',
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// USAGE EXAMPLES
// ==========================================
