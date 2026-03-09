import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/features/profile/presentation/widgets/profile_widget/profile_menue_item.dart';
import 'package:fodwa/features/profile/presentation/widgets/profile_widget/sections_decoration.dart';

class BuildMyAccountsAs extends StatelessWidget {
  const BuildMyAccountsAs({super.key});

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
                icon: Icons.local_taxi_outlined,
                title: 'Taxi Driver in Fodwa',
                onTap: () {},
              ),
              SizedBox(height: AppConstants.h * 0.01),
              ProfileMenuItem(
                icon: Icons.storefront_outlined,
                title: 'Seller in New Markt in Fodwa',
                onTap: () {},
              ),
              SizedBox(height: AppConstants.h * 0.01),
              ProfileMenuItem(
                icon: Icons.person_outline,
                title: 'Model in FODWA',
                onTap: () {},
              ),
              SizedBox(height: AppConstants.h * 0.01),
              ProfileMenuItem(
                icon: Icons.camera_alt_outlined,
                title: 'Advertising Photographer on the FODWA',
                onTap: () {},
              ),
              SizedBox(height: AppConstants.h * 0.01),
              ProfileMenuItem(
                icon: Icons.business_outlined,
                title: 'Hotel in FODWA?',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
