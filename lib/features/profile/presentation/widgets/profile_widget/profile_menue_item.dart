import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_texts.dart';
import 'package:fodwa/core/utils/app_constants.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData? icon;
  final String title;
  final VoidCallback onTap;
  final String? iconImage; // assets path
  final Color? iconColor;
  final Color? containerColor;

  const ProfileMenuItem({
    Key? key,
    this.icon,
    required this.title,
    required this.onTap,
    this.iconImage,
    this.iconColor,
    this.containerColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.w * 0.0213),
      child: Padding(
        /// optional touch padding
        padding: EdgeInsets.symmetric(
          /// 8 / 375
          horizontal: AppConstants.w * 0.0213,

          /// 6 / 1200
          vertical: AppConstants.h * 0.005,
        ),
        child: Row(
          children: [
            _buildIcon(),

            /// 8 (design spacing) / 375
            SizedBox(width: AppConstants.w * 0.0213),

            Expanded(
              child: Text(
                maxLines: 3,
                softWrap: true,
                overflow: TextOverflow.visible,
                title,
                style: AppTextStyles.titleMedium().copyWith(letterSpacing: 0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return SizedBox(
      width: AppConstants.w * 0.064,
      height: AppConstants.w * 0.064,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: containerColor ?? Color(0xFFECF1F6),
        ),
        child: Center(
          child: iconImage != null
              ? SizedBox(
                  width: AppConstants.w * 0.042,
                  height: AppConstants.w * 0.042,
                  child: Image.asset(
                    iconImage!,
                    fit: BoxFit.contain,
                    color: iconColor ?? AppColors.dividerGray,
                  ),
                )
              : Icon(
                  icon,
                  size: AppConstants.w * 0.051,
                  color: iconColor ?? AppColors.dividerGray,
                ),
        ),
      ),
    );
  }
}
