import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_images.dart';
import 'package:fodwa/features/home/presentation/widgets/home_widgets/search.dart';

import '../../../../../core/sharedWidget/fodwa_image.dart';
import '../../../../../core/utils/app_constants.dart';

class AppBarContent extends StatelessWidget {
  const AppBarContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,

      /// 24 / 375
      padding: EdgeInsets.symmetric(horizontal: AppConstants.w * 0.064),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              /// Logo Icon
              buildFodwaLogo(
                fit: BoxFit.fill,

                /// 28 / 375
                height: AppConstants.w * 0.075,
                width: AppConstants.w * 0.075,
              ),

              /// 7 / 375
              SizedBox(width: AppConstants.w * 0.0187),

              /// Logo Text
              buildFodwaAuthImage(
                fit: BoxFit.fill,

                /// 80 / 375
                width: AppConstants.w * 0.212,

                /// 22 / 812
                height: AppConstants.h * 0.027,
              ),

              const Spacer(),

              /// Icons Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildIconImage(AppImages.love),
                    _space(),

                    _buildIconWithBadge(icon: AppImages.shopping),
                    _space(),

                    _buildIconWithBadge(icon: AppImages.notification),
                    _space(),

                    _buildIconImage(AppImages.filterSearch),
                  ],
                ),
              ),
            ],
          ),

          /// 10 / 812
          SizedBox(height: AppConstants.h * 0.012),

          const SearchBarSection(),
        ],
      ),
    );
  }

  /// spacing between icons
  Widget _space() => SizedBox(width: AppConstants.w * 0.045);

  /// simple icon
  Widget _buildIconImage(String image) {
    return Image.asset(
      image,

      /// 20 / 375
      width: AppConstants.w * 0.053,
      height: AppConstants.w * 0.053,
    );
  }

  /// icon with badge
  Widget _buildIconWithBadge({required String icon}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          icon,

          /// 18 / 375
          width: AppConstants.w * 0.048,
          height: AppConstants.w * 0.048,
        ),

        Positioned(
          /// -3 / 375
          top: AppConstants.w * -0.008,
          right: AppConstants.w * -0.008,
          child: Container(
            /// 13 / 375
            width: AppConstants.w * 0.035,
            height: AppConstants.w * 0.035,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '2',
              style: TextStyle(
                color: Colors.white,

                /// 10 / 375
                fontSize: AppConstants.w * 0.027,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
