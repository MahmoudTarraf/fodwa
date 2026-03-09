import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_images.dart';
import 'package:fodwa/core/utils/app_texts.dart';
import 'package:fodwa/generated/locale_keys.g.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/features/Auth/login/presentation/bloc/bloc.dart';
import 'package:fodwa/features/Auth/login/presentation/bloc/loginEvents.dart';

class CustomTabs extends StatelessWidget {
  const CustomTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.h * 0.046,
      width: AppConstants.w * 0.872,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.w * 0.037),
        border: Border.all(
          color: Colors.grey.shade300,
          width: AppConstants.w * 0.0027,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppConstants.w * 0.0067),
        child: Row(
          children: [
            Expanded(
              child: _TabItem(
                title: LocaleKeys.auth_email.tr(),
                icon: AppImages.sms,
                isSelected: context.watch<LoginBloc>().state.selectedTab == 0,
                onTap: () {
                  context.read<LoginBloc>().add(ChangeLoginTab(0));
                },
              ),
            ),
            Expanded(
              child: _TabItem(
                title: LocaleKeys.auth_phone.tr(),
                icon: AppImages.call,
                isSelected: context.watch<LoginBloc>().state.selectedTab == 1,
                onTap: () {
                  context.read<LoginBloc>().add(ChangeLoginTab(1));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        height: AppConstants.h * 0.046,
        width: AppConstants.w * 0.872,
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(AppConstants.w * 0.037),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: AppConstants.w * 0.043,
              height: AppConstants.w * 0.043,
              child: SvgPicture.asset(
                icon,
                width: AppConstants.w * 0.043,
                height: AppConstants.w * 0.043,
                color: isSelected ? Colors.white : AppColors.blackPrimaryColor,
              ),
            ),
            SizedBox(width: AppConstants.w * 0.016),
            Flexible(
              child: Text(
                title,
                style: AppTextStyles.displaySmall().copyWith(
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? Colors.white
                      : AppColors.blackPrimaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
