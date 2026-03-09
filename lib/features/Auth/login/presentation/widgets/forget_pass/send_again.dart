import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_constants.dart';

class SendAgain extends StatelessWidget {
  const SendAgain({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Send code again",
      style: TextStyle(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w500,
        fontSize: AppConstants.w * 0.032, // 12 / 375
      ),
    );
  }
}
