import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/forget_pass/send_again.dart';

import '../../../../../../core/sharedWidget/field.dart';
import '../../../../../../core/sharedWidget/larg_button.dart';
import '../../../../../../core/utils/app_constants.dart';
import '../../../../../../core/utils/app_images.dart';
import '../../../../../../core/utils/app_validator.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../widgets/login_text.dart';
import 'build_resend_code.dart';
import 'common.dart';

class CreateNewPass extends StatefulWidget {
  const CreateNewPass({
    super.key,
    required this.pass,
    required this.confirmPass,
    required this.onSubmit,
  });

  final VoidCallback onSubmit;
  final TextEditingController pass;
  final TextEditingController confirmPass;

  @override
  State<CreateNewPass> createState() => _CreateNewPassState();
}

class _CreateNewPassState extends State<CreateNewPass> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: AppConstants.w * 0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.w * 0.04),
        ),
        backgroundColor: const Color(0XFFF5F5F5),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.w * 0.045,
            vertical: AppConstants.h * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ForgetHeader(),

                SizedBox(height: AppConstants.h * 0.015),

                ForgetTitle(
                  title: "Reset Password",
                  description: "Create a new password.",
                ),

                SizedBox(height: AppConstants.h * 0.025),

                Align(
                  alignment: Alignment.centerLeft,
                  child: build_field_name("Password"),
                ),

                SizedBox(height: AppConstants.h * 0.01),

                CustomTextFormField(
                  controller: widget.pass,
                  validator: Validator.validatePassword,
                  hint: "************",
                  prefixImage: AppImages.lock1,
                  label: LocaleKeys.auth_email.tr(),
                  isPassword: true,
                ),

                SizedBox(height: AppConstants.h * 0.02),

                Align(
                  alignment: Alignment.centerLeft,
                  child: build_field_name("Confirm Password"),
                ),

                SizedBox(height: AppConstants.h * 0.01),

                CustomTextFormField(
                  controller: widget.confirmPass,
                  validator: (value) => Validator.validateConfirmPassword(value, widget.pass.text),
                  prefixImage: AppImages.lock1,
                  hint: "************",
                  label: LocaleKeys.auth_email.tr(),
                  isPassword: true,
                ),

                SizedBox(height: AppConstants.h * 0.02),

                BuildResendCode(),

                SizedBox(height: AppConstants.h * 0.012),

                SendAgain(),

                SizedBox(height: AppConstants.h * 0.025),

                large_button(
                  onPressed: reset_passw_function,
                  buttonName: "Reset Password",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void reset_passw_function() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit();
    }
  }
}
