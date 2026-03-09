import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/features/Auth/signUp/data/models/sign_up_model.dart';

import '../../../../../../core/sharedWidget/large_field.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_constants.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../../../../core/sharedWidget/fodwa_image.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/socialLogin/buildSocilaLogin.dart';
import '../../../../login/presentation/widgets/widgets/login_text.dart';
import '../../manager/sign_up_bloc.dart';
import '../../manager/sign_up_events.dart';
import '../../manager/sign_up_states.dart';
import '../common/build_pass.dart';
import '../common/build_sign_up_fiedls.dart';
import '../signUpWidget/policy.dart';
import '../signUpWidget/profile_image_picker.dart';
import '../signUpWidget/signUpBanner.dart';
import '../signUpWidget/signUpTexts.dart'
    show SignUpHeader, haveAccount, build_policy;
import 'build_acc_details.dart';

class SignUpScreenItem extends StatefulWidget {
  const SignUpScreenItem({super.key});

  @override
  State<SignUpScreenItem> createState() => _SignUpScreenItemState();
}

class _SignUpScreenItemState extends State<SignUpScreenItem> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _buildingController = TextEditingController();
  final _apartmentController = TextEditingController();
  final _passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final _aboutMeController = TextEditingController();
  final _emailController = TextEditingController();
  final TextEditingController taxNumberController = TextEditingController();

  final TextEditingController servicesOfferedController =
      TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    taxNumberController.dispose();
    _emailController.dispose();
    phoneController.dispose();
    _phoneController.dispose();
    servicesOfferedController.dispose();
    _streetController.dispose();
    _neighborhoodController.dispose();
    _buildingController.dispose();
    _apartmentController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF5F5F5),
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Color(0XFFF5F5F5),
      ),
      body: _build_content(),
    );
  }

  Widget _build_content() {
    return Form(
      key: _formKey,
      child: Center(
        child: Padding(
          /// 24 / 375
          padding: EdgeInsets.symmetric(horizontal: AppConstants.w * 0.064),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 65 / 812
                SizedBox(height: AppConstants.h * 0.023),

                Center(child: buildFodwaAuthImage()),

                /// 16 / 812
                SizedBox(height: AppConstants.h * 0.043),

                const SignUpHeader(),

                /// 16 / 812
                SizedBox(height: AppConstants.h * 0.0110),

                const SignUpBanner(),

                /// 12 / 812
                SizedBox(height: AppConstants.h * 0.015),

                const ProfileImagePicker(),

                /// 12 / 812
                SizedBox(height: AppConstants.h * 0.015),

                BlocBuilder<SignUpBloc, SignUpState>(
                  buildWhen: (prev, curr) => prev.isoCode != curr.isoCode,
                  builder: (context, state) {
                    return BuildSignUpFields(
                      isoCode: state.isoCode,
                      phoneController: phoneController,
                      apartmentController: _apartmentController,
                      nameController: _nameController,
                      emailController: _emailController,
                      streetController: _streetController,
                      buildingController: _buildingController,
                      onPhoneChanged: (number, isoCode) {
                        context.read<SignUpBloc>().add(
                          UpdatePhoneNumberEvent(
                            phoneNumber: number,
                            isoCode: isoCode,
                          ),
                        );
                      },
                    );
                  },
                ),

                BuildAccountDetails(
                  taxNumberController: taxNumberController,
                  servicesOfferedController: servicesOfferedController,
                ),

                SizedBox(height: AppConstants.h * 0.015),

                BuildPasswordFields(
                  confirmPasswordController: _confirmPasswordController,
                  passwordController: _passwordController,
                ),

                SizedBox(height: AppConstants.h * 0.015),

                build_field_name(LocaleKeys.auth_aboutMe.tr()),

                /// 8 / 812
                SizedBox(height: AppConstants.h * 0.01),

                CustomTextField(
                  controller: _aboutMeController,
                  maxLines: 2,
                  maxLength: 700,
                ),

                SizedBox(height: AppConstants.h * 0.015),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.w * 0.01,
                  ),
                  child: Row(
                    children: [
                      const RememberCheckBox(),
                      const SizedBox(width: 8),
                      Expanded(child: build_policy()),
                    ],
                  ),
                ),

                /// 12 / 812
                SizedBox(height: AppConstants.h * 0.015),

                _build_sign_up_button(),

                /// 16 / 812
                SizedBox(height: AppConstants.h * 0.02),

                Center(child: build_or_text()),

                /// 16 / 812
                SizedBox(height: AppConstants.h * 0.02),

                const Center(child: SocialLogin()),

                /// 16 / 812
                SizedBox(height: AppConstants.h * 0.02),

                haveAccount(onTap: () {}, context: context),

                /// 16 / 812
                SizedBox(height: AppConstants.h * 0.02),

                /// bottom safe spacing
                SizedBox(height: AppConstants.h * 0.015),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _build_sign_up_button() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        final isAllAccepted = state.isPolicyAccepted;

        return SizedBox(
          height: AppConstants.h * 0.054,
          width: double.infinity,
          child: Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.pColor,
                disabledBackgroundColor: const Color(
                  0xFFFB7185,
                ), // Even more vibrant Red Accent
                minimumSize: Size(AppConstants.w * 0.8, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: isAllAccepted ? 2 : 0,
              ),
              onPressed: isAllAccepted
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        final user = SignUpModel(
                          servicesOffered: state.selectedServices.isNotEmpty
                              ? state.selectedServices
                              : null,
                          taxNumber: taxNumberController.text,
                          businessSector:
                              state.selectedBusinessSector?.name ?? '',
                          accountType: state.accountType?.name ?? '',
                          pass: _passwordController.text,
                          confirmPass: _confirmPasswordController.text,
                          phone:
                              state.phoneNumberText ??
                              phoneController.text.trim(),
                          name: _nameController.text.trim(),
                          email: _emailController.text.trim(),
                          aboutMe: _aboutMeController.text.trim(),
                          street: _streetController.text,
                          building: _buildingController.text,
                          apartment: _apartmentController.text,
                          createdAt: DateTime.now(),
                          country: state.selectedCountry?.name ?? "",
                          countryCode:
                              state.selectedCountry?.isoCode ??
                              state.isoCode ??
                              'SA',
                          city: state.selectedCity?.name ?? '',
                          gender: state.gender?.name,
                          generalJob: state.selectedGeneralJob?.name,
                          relatedJob: state.selectedRelatedJob?.name,
                          skills: state.selectedSkills.isNotEmpty
                              ? state.selectedSkills
                              : null,
                          dateOfBirth: state.dateOfBirth,
                          profileImage: state.profileImagePath,
                          bannerImage: state.bannerImagePath,
                        );

                        context.read<SignUpBloc>().add(
                          SignUpButtonPressed(user),
                        );
                      }
                    }
                  : null,
              child: Center(
                child: Text(
                  LocaleKeys.auth_signUp.tr(),
                  style: TextStyle(
                    color: const Color(0XFFFAFAFA),
                    fontWeight: FontWeight.w600,
                    fontSize: AppConstants.w * 0.043,
                    fontFamily: 'Nexa Bold 650',
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
