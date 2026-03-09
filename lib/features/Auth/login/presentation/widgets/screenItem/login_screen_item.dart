import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/sharedWidget/fodwa_image.dart';
import 'package:fodwa/config/routes/app_router.dart';
import 'package:fodwa/features/Auth/login/presentation/bloc/bloc.dart';
import 'package:fodwa/features/Auth/login/presentation/bloc/login_states.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/socialLogin/buildSocilaLogin.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/taps/tabs_item.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/widgets/login_text.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/screenItem/login_screen_email_item.dart';
import 'package:fodwa/features/Auth/login/presentation/widgets/screenItem/login_screen_phone_item.dart';

class LoginScreenItem extends StatelessWidget {
  const LoginScreenItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF5F5F5),
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: const Color(0XFFF5F5F5),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.w * 0.064),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100.5),
                Center(child: buildFodwaAuthImage()),
                SizedBox(height: AppConstants.h * 0.03),
                Center(child: welcom_login_text()),
                SizedBox(height: AppConstants.h * 0.005),
                Center(child: welcom_login_sub_headline()),
                SizedBox(height: AppConstants.h * 0.03),
                const Center(child: CustomTabs()),
                SizedBox(height: AppConstants.h * 0.03),
                BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (previous, current) {
                    // ⚠️ Don't rebuild if only phone number changed (handled internally)
                    // But DO rebuild if the selected tab changed.
                    return previous.selectedTab != current.selectedTab;
                  },
                  builder: (context, state) {
                    if (state.selectedTab == 0) {
                      return const LoginScreenEmailItem();
                    } else {
                      return const LoginScreenPhoneItem();
                    }
                  },
                ),
                SizedBox(height: AppConstants.h * 0.02),
                Center(child: build_or_text()),
                SizedBox(height: AppConstants.h * 0.02),
                const Center(child: SocialLogin()),
                SizedBox(height: AppConstants.h * 0.02),
                Center(child: guest_text(context)),
                SizedBox(height: AppConstants.h * 0.02),
                dontHaveAccount(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.signUp);
                  },
                ),
                SizedBox(height: AppConstants.h * 0.150),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
