import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/features/Auth/login/presentation/pages/login_screen.dart';
import 'package:fodwa/core/intialization/initiDI.dart';
import 'package:fodwa/core/networkError/main_wrapper.dart';
import 'package:fodwa/core/sharedWidget/app_snack_par.dart';
import 'package:fodwa/core/sharedWidget/custom_loading.dart';
import 'package:fodwa/features/Auth/signUp/domain/use_cases/sign_up_use_case.dart';
import 'package:fodwa/features/Auth/signUp/presentation/manager/sign_up_bloc.dart';
import 'package:fodwa/features/Auth/signUp/presentation/manager/sign_up_states.dart';
import 'package:fodwa/features/Auth/signUp/presentation/widgets/screensItem/sign_up_screen_item.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpBloc(signUpUseCase: getIt<SignUpUseCase>()),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) {
          // Only rebuild if the state type changed or critical fields changed.
          // Don't rebuild for every phone number keystroke.
          return previous.runtimeType != current.runtimeType;
        },
        listenWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,
        listener: (context, state) async {
          if (state is SignUpLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Dialog(
                backgroundColor: Colors.transparent,
                child: CustomLoadingWidget(),
              ),
            );
          } else if (state is SignUpSuccess) {
            Navigator.of(context, rootNavigator: true).pop();

            // Show success message to user
            AppSnackBar.showSuccess(context, state.message);

            // Navigate to login screen with email for verification
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(
                    email: state.email,
                    profileImagePath: state.profileImagePath,
                  ),
                ),
                (route) => false,
              );
            });
          } else if (state is SignUpFailure) {
            Navigator.of(context, rootNavigator: true).pop();
            AppSnackBar.showError(context, state.error);
          } else if (state is SignUpValidationError) {
            AppSnackBar.showError(context, state.error);
          }
        },
        builder: (context, state) {
          return MainWrapper(
            childWidget: AbsorbPointer(
              absorbing: state is SignUpLoading,
              child: const SignUpScreenItem(),
            ),
          );
        },
      ),
    );
  }
}
