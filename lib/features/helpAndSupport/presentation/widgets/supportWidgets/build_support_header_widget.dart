import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_constants.dart';

class BuildHelpHeaderWidgetSection extends StatelessWidget {
  final IconData? icon;
  final String? iconImage; // assets path

  final String title;
  final String subtitle;

  const BuildHelpHeaderWidgetSection({
    super.key,
    this.iconImage,
    this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    /// init size (375 × 812)
    AppConstants.initSize(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _IconContainer(
          icon: icon,
          iconImage: iconImage,
        ),

        SizedBox(
          width: AppConstants.w * 0.032, // 12 / 375
        ),

        Expanded(
          child: _TextSection(
            title: title,
            subtitle: subtitle,
          ),
        ),
      ],
    );
  }
}

class _IconContainer extends StatelessWidget {
  final IconData? icon;
  final String? iconImage;

  const _IconContainer({this.icon, this.iconImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.w * 0.064, // 24 / 375
      height: AppConstants.w * 0.064, // 24 / 375
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: iconImage != null
            ? Image.asset(
          iconImage!,
          width: AppConstants.w * 0.0427, // 16 / 375
          height: AppConstants.w * 0.0427, // 16 / 375
          color: Colors.white, // توحيد اللون
        )
            : Icon(
          icon,
          color: Colors.white,
          size: AppConstants.w * 0.0427, // 16 / 375
        ),
      ),
    );
  }
}

class _TextSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const _TextSection({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            letterSpacing: 0,
            height: 0,
            fontSize: AppConstants.w * 0.0373, // 14 / 375
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
            color: const Color(0xFF171725),
          ),
        ),

        SizedBox(
          height: AppConstants.h * 0.00493, // 4 / 812
        ),

        Text(
          subtitle,
          style: TextStyle(
            fontSize: AppConstants.w * 0.0373, // 14 / 375
            fontWeight: FontWeight.w500,
            color: const Color(0xFF66707A),
          ),
        ),
      ],
    );
  }
}
