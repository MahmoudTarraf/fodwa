import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_constants.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        /// 24 (design horizontal padding) / 375
        horizontal: AppConstants.w * 0.064,

        /// 8 (design vertical padding) / 1200
        vertical: AppConstants.h * 0.0067,
      ),
      color: const Color(0xFFF9FAFB),
      child: Text(
        title,
        style: TextStyle(
          /// 12 (design font size) / 375
          fontSize: AppConstants.w * 0.032,
          color: const Color(0xFF9CA3AF),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
