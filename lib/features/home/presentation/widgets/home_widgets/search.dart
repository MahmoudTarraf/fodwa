import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_texts.dart';
import 'package:fodwa/core/utils/app_constants.dart';

// Search Bar Section Component
class SearchBarSection extends StatelessWidget {
  const SearchBarSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Search Field
        Expanded(
          child: Container(
            /// 31 (design height) / 1200
            height: AppConstants.h * 0.042,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFD1D8DD),
              ),
              /// 4 (design radius) / 375
              borderRadius: BorderRadius.circular(
                AppConstants.w * 0.0107,
              ),
            ),
            child: Row(
              children: [
                /// 8 (design spacing) / 375
                SizedBox(width: AppConstants.w * 0.0213),

                /// Search Icon
                Icon(
                  Icons.search,
                  color: AppColors.primaryColor,
                  /// 16 (design icon size) / 375
                  size: AppConstants.w * 0.0427,
                ),

                /// 8 (design spacing) / 375
                SizedBox(width: AppConstants.w * 0.0213),

                /// TextField
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(


                      hintText: 'What are you looking for?',
                      hintStyle: AppTextStyles.titleMedium().copyWith(
                        color: const Color(0xFF9CA3AF),
                        fontWeight: FontWeight.w400,
                        /// 14 (design font size) / 375
                        fontSize: AppConstants.w * 0.0373,
                      ),
                      border: InputBorder.none,
                      isCollapsed: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        /// 12 (design spacing) / 375
        SizedBox(width: AppConstants.w * 0.032),

        /// Post Button
        SizedBox(
          /// 81 (design width) / 375
          width: AppConstants.w * 0.216,
          /// 32 (design height) / 1200
          height: AppConstants.h * 0.042,
           child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                /// 8 (design radius) / 375
                borderRadius: BorderRadius.circular(
                  AppConstants.w * 0.005,
                ),
              ),
              elevation: 0,
            ),
            child: Text(
              'Post',
              style: TextStyle(
                color: Colors.white,
                /// 12 (design font size) / 375
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 0
              ),
            ),
          ),
        ),
      ],
    );
  }
}
