import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/features/Auth/login/presentation/bloc/loginEvents.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/forget_pass/create_new_pass.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/forget_pass/verify_number_screen.dart';
import 'package:fodwa/features/bottom_nav/bottom_nav.dart';
import 'package:fodwa/generated/locale_keys.g.dart';
import 'package:fodwa/core/intialization/initiDI.dart' show getIt;
import 'package:fodwa/core/networkError/main_wrapper.dart';
import 'package:fodwa/core/sharedWidget/app_snack_par.dart';
import 'package:fodwa/core/sharedWidget/custom_loading.dart';
import 'package:fodwa/core/sharedWidget/success_widget.dart';
import 'package:fodwa/features/Auth/login/domain/use_cases/forget_password_use_case.dart';
import 'package:fodwa/features/Auth/login/domain/use_cases/login_use_case.dart';
import 'package:fodwa/features/Auth/signUp/domain/use_cases/verify_registration_use_case.dart';
import 'package:fodwa/features/Auth/login/presentation/bloc/bloc.dart'
    show LoginBloc;
import 'package:fodwa/features/Auth/login/presentation/bloc/login_states.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/screenItem/login_screen_item.dart';

class LoginScreen extends StatefulWidget {
  final String? email;
  final String? profileImagePath;

  const LoginScreen({super.key, this.email, this.profileImagePath});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  bool _hasShownVerificationDialog = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(
        loginUseCase: getIt<LoginUseCase>(),
        forgetPasswordUseCase: getIt<ForgetPasswordUseCase>(),
        verifyRegistrationUseCase: getIt<VerifyRegistrationUseCase>(),
      ),
      child: Builder(
        builder: (builderContext) {
          // Show verification dialog if email is provided and not shown yet
          if (widget.email != null && !_hasShownVerificationDialog) {
            _hasShownVerificationDialog = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final loginBloc = builderContext.read<LoginBloc>();
              showDialog(
                context: builderContext,
                barrierDismissible: true,
                builder: (dialogContext) => VerifyNumberScreen(
                  numberController: numberController,
                  onSubmit: () {
                    Navigator.pop(dialogContext);
                    loginBloc.add(
                      VerifyRegistrationOtp(
                        email: widget.email!,
                        code: numberController.text,
                        profileImagePath: widget.profileImagePath,
                      ),
                    );
                  },
                ),
              );
            });
          }

          return BlocConsumer<LoginBloc, LoginState>(
            buildWhen: (previous, current) {
              // Rebuild only on type changes or tab changes.
              return previous.runtimeType != current.runtimeType ||
                  previous.selectedTab != current.selectedTab;
            },
            listener: (context, state) async {
              final loginBloc = context.read<LoginBloc>();

              if (state is LoginSuccess) {
                context.read<LoginBloc>().add(ResetLoginState());
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const BottomNav()),
                  (route) => false,
                );
              } else if (state is SendEmailSuccess) {
                AppSnackBar.showSuccess(context, "Code sent to your email");
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) => VerifyNumberScreen(
                    numberController: numberController,
                    onSubmit: () {
                      Navigator.pop(context);
                      loginBloc.add(
                        CodeVerify(
                          email: state.email,
                          phone: state.phoneNumber.phoneNumber,
                          code: numberController.text,
                        ),
                      );
                    },
                  ),
                );
              }
              if (state is VerifiedSuccess) {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) => CreateNewPass(
                    confirmPass: _confirmPass,
                    pass: _pass,
                    onSubmit: () {
                      Navigator.pop(context);
                      loginBloc.add(
                        CreateNewPassEvent(
                          email: state.email,
                          phone: state.phoneNumber.phoneNumber,
                          code: numberController.text,
                          pass: _pass.text,
                          confirmPass: _confirmPass.text,
                        ),
                      );
                    },
                  ),
                );
              }
              if (state is PasswordCreatedSuccess) {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) => SuccessDialog(
                    onButtonPressed: () {
                      Navigator.pop(context);
                    },
                    buttonText: LocaleKeys.auth_login.tr(),
                    headline: 'Password Update',
                    description: 'Your password has been updated',
                    showButton: true,
                  ),
                );
              } else if (state is RegistrationVerifiedSuccess) {
                AppSnackBar.showSuccess(context, "Email verified successfully");
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) => SuccessDialog(
                    onButtonPressed: () {
                      Navigator.pop(context);
                    },
                    buttonText: 'Continue',
                    headline: 'Email Verified',
                    description:
                        'Your email has been verified successfully. You can now log in.',
                    showButton: true,
                  ),
                );
              } else if (state is LoginFailure) {
                AppSnackBar.showError(context, state.error);
              }
            },
            builder: (context, state) {
              return MainWrapper(
                childWidget: AbsorbPointer(
                  absorbing: state is LoginLoading,
                  child: Stack(
                    children: [
                      const LoginScreenItem(),
                      if (state is LoginLoading ||
                          state is ForgetEmailPassLoading)
                        const CustomLoadingWidget(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
