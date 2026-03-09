import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fodwa/core/sharedWidget/field.dart';
import 'package:fodwa/core/sharedWidget/larg_button.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/app_images.dart';
import 'package:fodwa/core/utils/app_validator.dart';
import 'package:fodwa/generated/locale_keys.g.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/widgets/login_text.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/forget_pass/common.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key, required this.onSubmit});

  final void Function(String email) onSubmit;

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: AppConstants.w * 0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.w * 0.04),
          side: const BorderSide(color: Color(0XFFD1D8DD)),
        ),
        backgroundColor: const Color(0XFFF5F5F5),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.w * 0.045,
            vertical: AppConstants.h * 0.02,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ForgetHeader(),
              SizedBox(height: AppConstants.h * 0.015),
              const ForgetTitle(),
              SizedBox(height: AppConstants.h * 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: build_field_name("Email"),
              ),
              SizedBox(height: AppConstants.h * 0.01),
              CustomTextFormField(
                controller: _emailController,
                validator: Validator.validateEmail,
                prefixImage: AppImages.smsImage,
                hint: "example@gmail.com",
                label: LocaleKeys.auth_email.tr(),
                isPassword: false,
              ),
              SizedBox(height: AppConstants.h * 0.015),
              large_button(
                onPressed: reset_passw_function,
                buttonName: "Send Reset Code",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void reset_passw_function() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_emailController.text.trim());
    }
  }
}
