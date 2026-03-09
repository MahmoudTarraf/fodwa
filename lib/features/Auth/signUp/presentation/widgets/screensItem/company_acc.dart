import 'package:flutter/cupertino.dart';

import '../../../../../../core/sharedWidget/field.dart';
import '../../../../../../core/utils/app_constants.dart';
import '../../../../../../core/utils/app_validator.dart';
import '../../../../login/presentation/widgets/widgets/login_text.dart';

import '../signUpWidget/dropDownLists/build_seriveces_offer_company_acc.dart';
import '../signUpWidget/dropDownLists/busness_sector.dart';

class CompanyAcc extends StatelessWidget {
  final TextEditingController taxNumberController;
  final TextEditingController servicesOfferedController;

  const CompanyAcc({
    super.key,
    required this.taxNumberController,
    required this.servicesOfferedController,
  });

  @override
  Widget build(BuildContext context) {
    // init size (375 × 812)
    AppConstants.initSize(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BuildBusinessSector(),

        SizedBox(
          height: AppConstants.h * 0.0148, // 12 / 812
        ),

        build_field_name('Tax number'),

        SizedBox(
          height: AppConstants.h * 0.0098, // 8 / 812
        ),

        CustomTextFormField(
          controller: taxNumberController,
          keyboardType: TextInputType.number,
          label: 'Tax number',
          hint: '00000',
          validator: Validator.validateField,
        ),

        SizedBox(
          height: AppConstants.h * 0.0148, // 12 / 812
        ),

        build_field_name('Services offered'),

        SizedBox(
          height: AppConstants.h * 0.0098, // 8 / 812
        ),

        CustomTextFormField(
          controller: servicesOfferedController,
          keyboardType: TextInputType.text,
          label: 'Services offered',
          hint: 'Cleaning, Maintenance ...',
          validator: Validator.validateField,
        ),

        SizedBox(
          height: AppConstants.h * 0.0148, // 12 / 812
        ),

        const BuildServicesOfferedSelector(),
      ],
    );
  }
}
