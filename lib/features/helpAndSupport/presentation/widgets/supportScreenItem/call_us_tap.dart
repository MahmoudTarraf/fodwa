import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/app_images.dart';

import '../supportWidgets/build_support_header_widget.dart';
import '../supportWidgets/build_support_widget.dart';

class CallUsTap extends StatefulWidget {
  const CallUsTap({super.key});

  @override
  State<CallUsTap> createState() => _CallUsTapState();
}

class _CallUsTapState extends State<CallUsTap> {
  @override
  Widget build(BuildContext context) {
    /// init size (375 × 812)
    AppConstants.initSize(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.w * 0.064),
        child: Column(
          children: [
            SizedBox(
              height: AppConstants.h * 0.0197, // 16 / 812
            ),

            const BuildSupportWidget(),

            SizedBox(
              height: AppConstants.h * 0.0148, // 12 / 812
            ),

            _buildWidgetDecoration(
              BuildHelpHeaderWidgetSection(
                iconImage: "assets/images/sms.png",
                title: 'Email Support',
                subtitle: 'mohammed.kudjar@gmail.com',
              ),
            ),

            SizedBox(
              height: AppConstants.h * 0.0148, // 12 / 812
            ),

            _buildWidgetDecoration(
              BuildHelpHeaderWidgetSection(
                iconImage: AppImages.call2,
                title: 'Phone Support',
                subtitle: '+43 676 320 5041',
              ),
            ),

            SizedBox(
              height: AppConstants.h * 0.0296, // 24 / 812
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetDecoration(Widget childWidget) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        AppConstants.w * 0.032, // 12 / 375
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AppConstants.w * 0.032, // 8 / 375
        ),
        border: Border.all(
          color: const Color(0xFFD1D8DD),
          width: AppConstants.w * 0.00267, // 1 / 375
        ),
      ),
      child: childWidget,
    );
  }
}
