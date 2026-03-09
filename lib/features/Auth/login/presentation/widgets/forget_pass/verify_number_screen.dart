import 'package:flutter/material.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/forget_pass/build_resend_code.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/forget_pass/common.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/forget_pass/send_again.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../../core/sharedWidget/larg_button.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_constants.dart';

class VerifyNumberScreen extends StatefulWidget {
  const VerifyNumberScreen({
    super.key,
    required this.onSubmit,
    required this.numberController,
  });

  final TextEditingController numberController;
  final VoidCallback onSubmit;

  @override
  State<VerifyNumberScreen> createState() => _VerifyNumberScreenState();
}

class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Dialog(
        /// 16 / 375
        insetPadding: EdgeInsets.symmetric(horizontal: AppConstants.w * 0.0427),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppConstants.w * 0.042, // 16 / 375
          ),
        ),
        backgroundColor: Color(0XFFF5F5F5),
        child: Container(
          /// 327 / 375
          width: AppConstants.w * 0.872,

          child: Padding(
            /// 16 / 375
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.w * 0.045,
              vertical: AppConstants.h * 0.02,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(child: ForgetHeader()),

                  /// 16 / 812
                  SizedBox(height: AppConstants.h * 0.0197),

                  ForgetTitle(
                    title: "Verify Code",
                    description:
                        "Enter the code sent to your email to verify your identity",
                  ),

                  /// 16 / 812
                  SizedBox(height: AppConstants.h * 0.0197),

                  _buildPinCodeFields(context),

                  /// 10 / 812
                  SizedBox(height: AppConstants.h * 0.004),

                  const BuildResendCode(),
                  SizedBox(height: AppConstants.h * 0.0197),

                  const SendAgain(),

                  /// 4 / 812
                  SizedBox(height: AppConstants.h * 0.012),

                  large_button(
                    onPressed: widget.onSubmit,
                    buttonName: "Verify",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinCodeFields(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: PinCodeTextField(
        controller: widget.numberController,
        hintCharacter: '0',
        hintStyle: TextStyle(
          color: Color(0XFFBFC6CC),
          fontSize: AppConstants.w * 0.048,
        ),
        appContext: context,
        autoFocus: true,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        length: 6,
        animationType: AnimationType.scale,
        enableActiveFill: true,
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Color(0XFFF5F5F5),
        onChanged: (_) {},
        onCompleted: (_) {},

        textStyle: TextStyle(
          color: AppColors.primaryColor,
          fontSize: AppConstants.w * 0.053,
          fontWeight: FontWeight.bold,
        ),

        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          activeBorderWidth: 1,
          inactiveBorderWidth: 1,
          selectedBorderWidth: 1,
          fieldHeight: AppConstants.h * 0.054,
          fieldWidth:
              AppConstants.w * 0.12, // Reduced from 0.181 to fit 6 fields
          borderWidth: 1,
          activeColor: Color(0XFFD1D8DD),
          inactiveColor: Color(0XFFD1D8DD),
          selectedColor: Colors.red,
          inactiveFillColor: Colors.white,
          activeFillColor: const Color(0xFFfdfdfd),
          selectedFillColor: const Color(0xFFfdfdfd),
        ),
      ),
    );
  }
}
