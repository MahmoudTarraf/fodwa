import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/app_images.dart';
import 'package:fodwa/features/profile/presentation/widgets/profile_widget/profile_menue_item.dart';
import 'package:fodwa/features/profile/presentation/widgets/profile_widget/sections_decoration.dart';

class BuildHowToBe extends StatelessWidget {
  const BuildHowToBe({super.key});

  @override
  Widget build(BuildContext context) {
    return build_profile_decoration(
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.w * 0.032,
            vertical: AppConstants.h * 0.01,
          ),
          child: Column(
            children: [
              ProfileMenuItem(
                iconImage: AppImages.starProfile,
                iconColor: Colors.red,
                title: 'How to become an Influencer in FODWA?',
                containerColor: AppColors.whiteProfile,
                onTap: () {},
              ),
              SizedBox(height: AppConstants.h * 0.01),
              ProfileMenuItem(
                iconImage: AppImages.sellerProfile,
                iconColor: Colors.red,
                title: 'How to become a Seller in New Markt?',
                containerColor: AppColors.whiteProfile,
                onTap: () {},
              ),
              SizedBox(height: AppConstants.h * 0.01),
              ProfileMenuItem(
                iconImage: AppImages.buildingProfile,
                iconColor: Colors.red,
                title: 'How to add your Hotel in FODWA?',
                containerColor: AppColors.whiteProfile,
                onTap: () {},
              ),
              SizedBox(height: AppConstants.h * 0.01),
              ProfileMenuItem(
                iconImage: AppImages.taxiProfile,
                iconColor: Colors.red,
                containerColor: AppColors.whiteProfile,
                title: 'How to register your Taxi as a taxi in FODWA?',
                onTap: () {},
              ),
              SizedBox(height: AppConstants.h * 0.01),
              ProfileMenuItem(
                iconImage: AppImages.userProfile,
                iconColor: Colors.red,
                containerColor: AppColors.whiteProfile,
                title: 'How to Become a Model on the FODWA ?',
                onTap: () {},
              ),
              SizedBox(height: AppConstants.h * 0.01),
              ProfileMenuItem(
                iconImage: AppImages.cameraProfile,
                iconColor: Colors.red,
                containerColor: AppColors.whiteProfile,
                title:
                    'How to Become a Product & Advertising Photographer on the FODWA ?',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
