import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/features/profile/presentation/pages/profile_screen.dart';

import '../../core/utils/app_images.dart';
import '../home/presentation/widgets/home_screens_item/home_page_item.dart'
    show HomePageItem;
import '../messages/presentation/pages/messages_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    /// init size (375 × 812)
    AppConstants.initSize(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,

      backgroundColor: Colors.grey,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppConstants.w * 0.075, // 28 / 375
          ),
        ),
        onPressed: () {
          // floatingButtonSheet();
        },
        child: Icon(
          Icons.add_circle_outline,
          size: AppConstants.w * 0.0667, // 25 / 375
          color: Colors.white,
        ),
      ),

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent, // ❌ ripple
          highlightColor: Colors.transparent, // ❌ highlight
          hoverColor: Colors.transparent,
        ),
        child: BottomAppBar(
          color: Colors.white,

          /// 🔴 مهم جداً
          height: AppConstants.h * 0.102, // 83 / 812
          shape: const CircularNotchedRectangle(),
          notchMargin: AppConstants.w * 0.032, // 12 / 375
          padding: EdgeInsets.all(
            AppConstants.w * 0.0, // 0 / 375
          ),

          elevation: AppConstants.h * 0.0148, // 12 / 812

          child: BottomNavigationBar(
            currentIndex: index,
            onTap: (i) {
              if (i == 2) return;
              setState(() => index = i);
            },

            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,

            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.grey,

            items: [
              /// HOME
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppImages.home,
                  width: AppConstants.w * 0.064, // 24 / 375
                  height: AppConstants.w * 0.064, // 24 / 375
                  color: index == 0 ? AppColors.primaryColor : Colors.grey,
                ),
                label: 'Home',
              ),

              /// CARS
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppImages.car,
                  width: AppConstants.w * 0.064, // 24 / 375
                  height: AppConstants.w * 0.064, // 24 / 375
                  color: index == 1 ? AppColors.primaryColor : Colors.grey,
                ),
                label: 'Cars',
              ),

              /// DUMMY
              const BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),

              /// MESSAGES
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppImages.message,
                  width: AppConstants.w * 0.064, // 24 / 375
                  height: AppConstants.w * 0.064, // 24 / 375
                  color: index == 3 ? AppColors.primaryColor : Colors.grey,
                ),
                label: 'Messages',
              ),

              /// PROFILE
              BottomNavigationBarItem(
                icon: Image.asset(
                  AppImages.profile,
                  width: AppConstants.w * 0.064, // 24 / 375
                  height: AppConstants.w * 0.064, // 24 / 375
                  color: index == 4 ? AppColors.primaryColor : Colors.grey,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),

      body: tabs[index],
    );
  }

  final List<Widget> tabs = const [
    HomePageItem(),
    Center(child: Text('Cars Coming Soon')),
    SizedBox.shrink(),
    MessagesScreen(),
    ProfileScreen(),
  ];
}
