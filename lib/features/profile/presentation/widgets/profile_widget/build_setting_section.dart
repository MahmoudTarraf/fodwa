import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/features/profile/presentation/widgets/profile_widget/profile_menue_item.dart';
import 'package:fodwa/features/profile/presentation/widgets/profile_widget/sections_decoration.dart';

import '../../../../../core/utils/app_images.dart';

class BuildSettingSection extends StatefulWidget {
  const BuildSettingSection({super.key});

  @override
  State<BuildSettingSection> createState() => _BuildSettingSectionState();
}

class _BuildSettingSectionState extends State<BuildSettingSection> {
  @override
  Widget build(BuildContext context) {
    return build_profile_decoration(
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            /// 12 (design horizontal padding) / 375
            horizontal: AppConstants.w * 0.032,

            /// 12 (design vertical padding) / 1200
            vertical: AppConstants.h * 0.01,
          ),
          child: Column(
            children: [
              ProfileMenuItem(
                iconImage: AppImages.lock1,
                title: 'Change Password',
                onTap: () {},
              ),

              /// 12 (design spacing) / 1200
              SizedBox(height: AppConstants.h * 0.01),

              ProfileMenuItem(
                icon: Icons.share_outlined,
                title: 'Social links',
                onTap: () {},
              ),

              /// 12 (design spacing) / 1200
              SizedBox(height: AppConstants.h * 0.01),

              ProfileMenuItem(
                icon: Icons.language_outlined,
                title: 'Language',
                onTap: () {},
              ),

              /// 12 (design spacing) / 1200
              SizedBox(height: AppConstants.h * 0.01),

              ProfileMenuItem(
                icon: Icons.verified_outlined,
                title: 'Account Verification',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
