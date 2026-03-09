import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/app_images.dart';
import 'package:fodwa/features/profile/presentation/widgets/myAddress/no_address.dart';
import 'package:fodwa/features/profile/presentation/widgets/profile_widget/profile_menue_item.dart';
import 'package:fodwa/features/profile/presentation/widgets/profile_widget/sections_decoration.dart';
import 'package:fodwa/features/profile/presentation/pages/personal_details_screen.dart';

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({super.key});

  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
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
                iconImage: AppImages.profile,
                title: 'Personal Details',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonalDetailsScreen()));
                },
              ),

              /// 12 (design spacing) / 1200
              SizedBox(height: AppConstants.h * 0.01),

              ProfileMenuItem(

                iconImage: AppImages.myOrder,
                title: 'My Order',
                onTap: () {},
              ),

              /// 12 (design spacing) / 1200
              SizedBox(height: AppConstants.h * 0.01),

              ProfileMenuItem(
                iconImage: AppImages.myBooking,
                title: 'My Booking',
                onTap: () {},
              ),

              /// 12 (design spacing) / 1200
              SizedBox(height: AppConstants.h * 0.01),

              ProfileMenuItem(
                iconImage: AppImages.location,
                 title: 'My Address',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      MyAddressScreen(),));
                },
              ),

              /// 12 (design spacing) / 1200
              SizedBox(height: AppConstants.h * 0.01),

              ProfileMenuItem(
                iconImage: AppImages.payment,
                title: 'Payment Method',
                onTap: () {},
              ),

              /// 16 (design spacing) / 1200
              SizedBox(height: AppConstants.h * 0.0133),
            ],
          ),
        ),
      ),
    );
  }
}
