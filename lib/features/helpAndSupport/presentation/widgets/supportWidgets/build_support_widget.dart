import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/features/chat/presentation/pages/chat_screen.dart';

import '../../../../../core/utils/app_images.dart';
import 'build_support_header_widget.dart';

class BuildSupportWidget extends StatefulWidget {
  const BuildSupportWidget({super.key});

  @override
  State<BuildSupportWidget> createState() => _BuildSupportWidgetState();
}

class _BuildSupportWidgetState extends State<BuildSupportWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.w * 0.032),
          color: Colors.white,
          border: Border.all(color: const Color(0xFFD1D8DD), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildHelpHeaderWidgetSection(
              iconImage: AppImages.chat,
              title: 'Live Chat',
              subtitle: 'Chat with our AI assistant',
            ),

            SizedBox(height: AppConstants.h * 0.015),
            Row(
              children: [
                SizedBox(width: 36),
                SizedBox(
                  width: 245,
                  height: 32,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.ai,
                          color: Colors.white,

                          width: AppConstants.w * 0.04266,
                          height: AppConstants.h * 0.04266,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Start Chat',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 0,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 6),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
