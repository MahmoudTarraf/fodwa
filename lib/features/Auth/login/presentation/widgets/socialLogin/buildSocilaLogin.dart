import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/core/utils/app_images.dart';
import 'package:fodwa/features/Auth/login/data/models/social_login_models.dart';
import 'package:fodwa/features/Auth/login/presentation/bloc/bloc.dart';
import 'package:fodwa/features/Auth/login/presentation/bloc/loginEvents.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class SocialLogin extends StatefulWidget {
  const SocialLogin({super.key});

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  // print(dotenv.env['GOOGLE_SERVER_CLIENT_ID']);
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
     serverClientId: dotenv.env['GOOGLE_SERVER_CLIENT_ID'] ?? "",
  );

  @override
  void initState() {
    super.initState();
    print(dotenv.env['GOOGLE_SERVER_CLIENT_ID']);
  }
  Future<void> _handleGoogleSignIn() async {
    try {
      await _googleSignIn.signOut(); // Ensure fresh login flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Debug: log both tokens to help diagnose auth issues
        debugPrint("[GoogleSignIn] idToken: ${googleAuth.idToken}");
        debugPrint("[GoogleSignIn] accessToken: ${googleAuth.accessToken}");

        final String? idToken = googleAuth.idToken;
        if (idToken == null || idToken.isEmpty) {
          debugPrint("[GoogleSignIn] ERROR: idToken is null. Check serverClientId configuration.");
          _showError(context, "auth.googleSignInError".tr());
          return;
        }

        if (mounted) {
          context.read<LoginBloc>().add(
            SocialLoginButtonPressed(
              model: SocialLoginModel(
                provider: "google",
                idToken: idToken,
              ),
            ),
          );
        }
      } else {
        debugPrint("[GoogleSignIn] Sign-In cancelled by user.");
      }
    } on PlatformException catch (e) {
      debugPrint("[GoogleSignIn] PlatformException Captured!");
      debugPrint("[GoogleSignIn] Code: ${e.code}");
      debugPrint("[GoogleSignIn] Message: ${e.message}");
      debugPrint("[GoogleSignIn] Details: ${e.details}");
      
      if (e.code == 'sign_in_canceled' || e.code == 'sign_in_cancelled') {
        _showError(context, "auth.signInCanceled".tr());
      } else {
        // ApiException: 10 = DEVELOPER_ERROR
        // Causes: SHA-1 mismatch in Google Cloud Console, or wrong serverClientId
        if (e.code == '10' || (e.message?.contains('10') ?? false)) {
          debugPrint("[GoogleSignIn] CRITICAL: ApiException 10 detected.");
          debugPrint("[GoogleSignIn] This ALMOST ALWAYS means the SHA-1 fingerprint in Google Cloud Console is wrong.");
          debugPrint("[GoogleSignIn] Also verify that the package name 'com.example.fodwa' matches the one in the console.");
        }
        _showError(context, "auth.googleSignInError".tr());
      }
    } catch (error, stackTrace) {
      debugPrint("[GoogleSignIn] Unexpected Error: $error");
      debugPrint("[GoogleSignIn] StackTrace: $stackTrace");
      _showError(context, "auth.googleSignInError".tr());
    }
  }

  Future<void> _handleAppleSignIn() async {
    try {
      WebAuthenticationOptions? webOptions;
      
      // Provide WebAuthenticationOptions for Android as required by sign_in_with_apple
      if (!kIsWeb && Platform.isAndroid) {
        webOptions = WebAuthenticationOptions(
          clientId: 'com.fodwa.app.service', // Adjust to match Apple Developer Console Service ID
          redirectUri: Uri.parse('https://fodwa-backend-blbwk.ondigitalocean.app/api/apple/callback'), // Adjust to real callback
        );
      }

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: webOptions,
      );

      if (mounted) {
        context.read<LoginBloc>().add(
          SocialLoginButtonPressed(
            model: SocialLoginModel(
              provider: "apple",
              identityToken: credential.identityToken ?? "",
              authorizationCode: credential.authorizationCode,
            ),
          ),
        );
      }
    } on SignInWithAppleAuthorizationException catch (e) {
      debugPrint("Apple Sign-In AuthException: ${e.code} - ${e.message}");
      if (e.code == AuthorizationErrorCode.canceled) {
        _showError(context, "auth.signInCanceled".tr());
      } else {
        _showError(context, "auth.appleSignInError".tr());
      }
    } catch (error) {
      debugPrint("Apple Sign-In Error: $error");
      _showError(context, "auth.appleSignInError".tr());
    }
  }

  void _showError(BuildContext context, String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _build_social_icon(
          child: Image.asset(
            AppImages.googleIcon,
            width: AppConstants.w * 0.075,
          ),
          onTap: _handleGoogleSignIn,
        ),
        SizedBox(width: AppConstants.w * 0.064),
        _build_social_icon(
          child: Icon(
            FontAwesomeIcons.apple,
            size: AppConstants.w * 0.075,
            color: Colors.black,
          ),
          onTap: _handleAppleSignIn,
        ),
      ],
    );
  }

  Widget _build_social_icon({
    required Widget child,
    required VoidCallback onTap,
  }) {
    return Material(
      elevation: AppConstants.h * 0.006,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Ink(
          width: AppConstants.w * 0.149,
          height: AppConstants.w * 0.149,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFF111111),
              width: AppConstants.w * 0.0027,
            ),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
