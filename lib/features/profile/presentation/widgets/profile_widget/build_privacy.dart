import 'package:flutter/material.dart';
import 'package:fodwa/config/routes/app_router.dart';
import 'package:fodwa/features/profile/presentation/widgets/profile_widget/profile_menue_item.dart';
import 'package:fodwa/features/profile/presentation/widgets/profile_widget/sections_decoration.dart'
    show build_profile_decoration;

import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_images.dart';

class BuildPrivacy extends StatefulWidget {
  const BuildPrivacy({super.key});

  @override
  State<BuildPrivacy> createState() => _BuildPrivacyState();
}

class _BuildPrivacyState extends State<BuildPrivacy> {
  @override
  Widget build(BuildContext context) {
    /// init size (375 × 812)
    AppConstants.initSize(context);

    return build_profile_decoration(
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.w * 0.032, // 12 / 375
            vertical: AppConstants.h * 0.0148, // 12 / 812
          ),
          child: Column(
            children: [
              ProfileMenuItem(
                icon: Icons.info_outline,
                title: 'About us',
                onTap: () {},
              ),

              SizedBox(
                height: AppConstants.h * 0.0148, // 12 / 812
              ),

              ProfileMenuItem(
                iconImage: AppImages.policy,
                title: 'Privacy Policy',
                onTap: () {},
              ),

              SizedBox(
                height: AppConstants.h * 0.0148, // 12 / 812
              ),

              ProfileMenuItem(
                iconImage: AppImages.help,
                title: 'Help & Support',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.help);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
