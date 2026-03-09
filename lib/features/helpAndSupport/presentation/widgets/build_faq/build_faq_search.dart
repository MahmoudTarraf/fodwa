import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_images.dart';
import '../../../../../core/utils/app_texts.dart';

class BuildFaqSearch extends StatefulWidget {
  const BuildFaqSearch({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  State<BuildFaqSearch> createState() => _BuildFaqSearchState();
}

class _BuildFaqSearchState extends State<BuildFaqSearch> {
  @override
  Widget build(BuildContext context) {
    /// init size (375 × 812)
    AppConstants.initSize(context);

    return Container(
      height: AppConstants.h * 0.0493, // 40 / 812
      width: AppConstants.w * 0.872, // 327 / 375
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryColor,
          width: AppConstants.w * 0.00267, // 1 / 375
        ),

        borderRadius: BorderRadius.circular(
          AppConstants.w * 0.0213, // 8 / 375
        ),
      ),
      child: Row(
        children: [
          /// left spacing
          SizedBox(
            width: AppConstants.w * 0.0213, // 8 / 375
          ),

          /// Search Icon
          Image.asset(
            AppImages.searchWw,
            width: AppConstants.w * 0.064, // 24 / 375
            height: AppConstants.w * 0.064, // 24 / 375
          ),

          /// spacing between icon & text
          SizedBox(
            width: AppConstants.w * 0.0213, // 8 / 375
          ),

          /// TextField
          Expanded(
            child: TextField(
              controller: widget.searchController,
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: AppTextStyles.titleMedium().copyWith(
                  color: const Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w400,
                  fontSize: AppConstants.w * 0.0373, // 14 / 375
                ),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
