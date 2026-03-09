import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/app_images.dart';
import 'package:fodwa/features/Auth/login/presentation/pages/login_screen.dart';
import 'package:fodwa/core/session/session_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class BuildLogout extends StatelessWidget {
  const BuildLogout({super.key});

  @override
  Widget build(BuildContext context) {
    /// init size (375 × 812)
    AppConstants.initSize(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.w * 0.064, // 24 / 375
      ),
      child: Container(
        width: double.infinity,
        height: AppConstants.h * 0.0616, // 50 / 812
        decoration: BoxDecoration(
          color: const Color(0xFFFFE5E5),
          borderRadius: BorderRadius.circular(
            AppConstants.w * 0.0213, // 8 / 375
          ),
        ),
        child: TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.w * 0.04),
                  ),
                  title: Center(
                    child: Text(
                      'Are You Sure?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppConstants.w * 0.048,
                      ),
                    ),
                  ),
                  content: const Text(
                    'Are you sure to Log Out',
                    textAlign: TextAlign.center,
                  ),
                  actionsAlignment: MainAxisAlignment.spaceEvenly,
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                    ),
                    TextButton(
                      onPressed: () async {
                        try {
                          await GoogleSignIn().signOut();
                        } catch (e) {
                          debugPrint("Google SignOut Error: $e");
                        }
                        await SessionManager.clearSession();
                        if (dialogContext.mounted) {
                          Navigator.pushAndRemoveUntil(
                            dialogContext,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                            (route) => false,
                          );
                        }
                      },
                      child: const Text('Log Out', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                );
              },
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.logOut,
                color: const Color(0xFFEF4444),
                width: AppConstants.w * 0.0533, // 20 / 375
              ),

              SizedBox(
                width: AppConstants.w * 0.0213, // 8 / 375
              ),

              Flexible(
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    color: const Color(0xFFEF4444),
                    fontSize: AppConstants.w * 0.0427, // 16 / 375
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
