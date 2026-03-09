import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/sharedWidget/field.dart';
import '../../../../../../core/utils/app_images.dart';
import '../../../../../../core/utils/app_validator.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../../login/presentation/widgets/widgets/login_text.dart';

import '../signUpWidget/password_requirements_widget.dart';

class BuildPasswordFields extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const BuildPasswordFields({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        build_field_name(LocaleKeys.auth_password.tr() + " *"),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: passwordController,
          validator: Validator.validatePassword,
          label: 'Password ',
          hint: '************',
          prefixImage: AppImages.lock1,
          isPassword: true,
        ),

        ListenableBuilder(
          listenable: passwordController,
          builder: (context, _) {
            return PasswordRequirementsWidget(
              password: passwordController.text,
            );
          },
        ),
        const SizedBox(height: 12),

        build_field_name(LocaleKeys.auth_confirmPassword.tr() + " *"),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: confirmPasswordController,
          validator: (value) =>
              Validator.validateConfirmPassword(value, passwordController.text),
          label: 'Confirm Password',
          hint: '************',
          prefixImage: AppImages.lock1,
          isPassword: true,
        ),
      ],
    );
  }
}
