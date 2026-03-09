import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/widgets/phone/build_phone_number.dart';
import 'package:fodwa/core/sharedWidget/app_snack_par.dart';
import 'package:fodwa/core/sharedWidget/field.dart';
import 'package:fodwa/core/sharedWidget/larg_button.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/app_images.dart';
import 'package:fodwa/core/utils/app_validator.dart';
import 'package:fodwa/generated/locale_keys.g.dart';
import 'package:fodwa/features/Auth/commonWidgets/build_mark.dart';
import 'package:fodwa/features/Auth/login/data/models/loginModel.dart';
import 'package:fodwa/features/Auth/login/presentation/bloc/bloc.dart';
import 'package:fodwa/features/Auth/login/presentation/bloc/loginEvents.dart';
import 'package:fodwa/features/Auth/login/presentation/bloc/login_states.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/widgets/login_text.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginScreenPhoneItem extends StatefulWidget {
  const LoginScreenPhoneItem({super.key});

  @override
  State<LoginScreenPhoneItem> createState() => _LoginScreenPhoneItemState();
}

class _LoginScreenPhoneItemState extends State<LoginScreenPhoneItem> {
  final _passwordController = TextEditingController();
  final _emailController =
      TextEditingController(); // though not used here directly for phone login
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) =>
          prev.runtimeType != curr.runtimeType ||
          prev.selectedTab != curr.selectedTab ||
          prev.phoneNumber.isoCode != curr.phoneNumber.isoCode,
      builder: (context, state) => _buildContent(context, state),
    );
  }

  Widget _buildContent(BuildContext context, LoginState state) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            build_field_name("Phone Number"),
            SizedBox(height: AppConstants.h * 0.01),
            BuildPhoneNumber(
              validator: Validator.validatePhone,
              isoCode: state.phoneNumber.isoCode,
              onChanged: (number, iso) {
                context.read<LoginBloc>().add(
                  UpdatePhoneNumber(
                    PhoneNumber(phoneNumber: number, isoCode: iso),
                  ),
                );
              },
            ),
            SizedBox(height: AppConstants.h * 0.015),
            build_field_name(LocaleKeys.auth_password.tr()),
            SizedBox(height: AppConstants.h * 0.01),
            CustomTextFormField(
              controller: _passwordController,
              validator: Validator.validatePassword,
              prefixImage: AppImages.lock1,
              hint: "************",
              label: "*****",
              isPassword: true,
            ),
            SizedBox(height: AppConstants.h * 0.007),
            SizedBox(
              width: AppConstants.w * 0.872,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buil_remember_mark(),
                  SizedBox(width: AppConstants.w * 0.021),
                  Expanded(child: build_remember()),
                  build_forget_pass(
                    context,
                    onSend: (email) {
                      context.read<LoginBloc>().add(
                        ForgetPasswordPressed(email: email),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: AppConstants.h * 0.021),
            large_button(
              onPressed: () {
                login_function(context);
              },
              buttonName: LocaleKeys.auth_login.tr(),
            ),
          ],
        ),
      ),
    );
  }

  void login_function(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final phoneNumber = context
          .read<LoginBloc>()
          .state
          .phoneNumber
          .phoneNumber;

      if (phoneNumber == null || phoneNumber.isEmpty) {
        AppSnackBar.showError(context, "Please enter a valid phone number");
        return;
      }

      final user = LoginModel(
        phone: phoneNumber,
        password: _passwordController.text.trim(),
      );

      context.read<LoginBloc>().add(LoginButtonPressed(model: user));
    }
  }
}
