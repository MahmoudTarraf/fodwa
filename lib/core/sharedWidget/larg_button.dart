import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

Widget large_button({
  required VoidCallback? onPressed, // ✅ كده يقبل null
  required String buttonName,
  bool isDisable = false,
  IconData? icon,
  Color? color,
  bool isDesktop = false,
}) => SizedBox(
  height: AppConstants.h * 0.054,
  width: double.infinity,
  child: Align(
    alignment: Alignment.center,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color == null ? AppColors.pColor : color,
        minimumSize: Size(AppConstants.w * 0.8, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      onPressed: isDisable ? null : onPressed,

      // ✅ مش لازم تعمل async call هنا
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(icon, color: Colors.white, size: AppConstants.w / 18),
            if (icon != null) SizedBox(width: AppConstants.w * 0.02),
            Text(
              buttonName,
              style: TextStyle(
                color: Color(0XFFFAFAFA),
                fontWeight: FontWeight.w600,
                fontSize: !isDesktop
                    ? AppConstants.w * 0.043
                    : AppConstants.w / 65,
                fontFamily: 'Nexa Bold 650',
              ),
            ),
          ],
        ),
      ),
    ),
  ),
);
