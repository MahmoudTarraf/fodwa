import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_images.dart';

import '../../../../../../core/sharedWidget/field.dart';
import '../../../../../../core/utils/app_validator.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../../login/presentation/widgets/widgets/login_text.dart';
import '../../../../login/presentation/widgets/widgets/phone/build_phone_number.dart';
import '../../../../../../core/utils/app_constants.dart';
import '../signUpWidget/dropDownLists/build-_account_type.dart';
import '../signUpWidget/dropDownLists/build_select_country.dart';
import '../signUpWidget/dropDownLists/build_selected_city_widget.dart';

class BuildSignUpFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController streetController;
  final TextEditingController buildingController;
  final TextEditingController apartmentController;
  final TextEditingController phoneController;
  final String? isoCode;
  final void Function(String number, String isoCode)? onPhoneChanged;

  const BuildSignUpFields({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.streetController,
    required this.apartmentController,
    required this.buildingController,
    this.isoCode,
    this.onPhoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        build_field_name(LocaleKeys.auth_fullName.tr()),
        SizedBox(height: AppConstants.h * 0.00985),
        CustomTextFormField(
          controller: nameController,
          validator: Validator.validateField,
          label: 'Full Name',
          hint: 'Your name',
          prefixImage: AppImages.profile,
        ),

        SizedBox(height: AppConstants.h * 0.015),

        build_field_name('Email *'),
        SizedBox(height: AppConstants.h * 0.00985),
        CustomTextFormField(
          controller: emailController,
          validator: Validator.validateEmail,
          label: 'Email',
          hint: 'example@ggmail.com',
          keyboardType: TextInputType.emailAddress,
          prefixImage: AppImages.smsImage,
        ),

        SizedBox(height: AppConstants.h * 0.015),

        build_field_name('Phone Number'),
        SizedBox(height: AppConstants.h * 0.00985),
        BuildPhoneNumber(
          validator: Validator.validatePhone,
          controller: phoneController,
          isoCode: isoCode,
          onChanged: onPhoneChanged,
        ),

        SizedBox(height: AppConstants.h * 0.015),

        const BuildSelectCountry(),

        SizedBox(height: AppConstants.h * 0.015),

        const BuildSelectedCityWidget(),

        SizedBox(height: AppConstants.h * 0.015),

        build_field_name(LocaleKeys.auth_street.tr()),

        /// 8 / 812
        SizedBox(height: AppConstants.h * 0.00985),

        CustomTextFormField(
          controller: streetController,
          validator: Validator.validateField,
          label: 'Street',
          hint: 'Street Name',
        ),

        /// 12 / 812
        SizedBox(height: AppConstants.h * 0.015),

        build_field_name(LocaleKeys.auth_buildingNumber.tr()),

        /// 8 / 812
        SizedBox(height: AppConstants.h * 0.00985),

        CustomTextFormField(
          controller: buildingController,
          validator: Validator.validateField,
          label: 'Building Number',
          hint: '5555555',
          keyboardType: TextInputType.number,
        ),

        /// 12 / 812
        SizedBox(height: AppConstants.h * 0.015),

        build_field_name(LocaleKeys.auth_apartmentNumber.tr()),

        /// 8 / 812
        SizedBox(height: AppConstants.h * 0.00985),

        CustomTextFormField(
          validator: Validator.validateField,
          keyboardType: TextInputType.number,
          label: 'Apartment number',
          hint: '123456',
          controller: apartmentController,
        ),

        SizedBox(height: AppConstants.h * 0.015),

        const BuildAccType(),

        SizedBox(height: AppConstants.h * 0.015),
      ],
    );
  }
}
