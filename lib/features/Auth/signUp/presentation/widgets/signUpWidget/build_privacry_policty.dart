import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_constants.dart';
import '../../../../../../core/utils/app_texts.dart';

class BuildPrivacyPolicy extends StatefulWidget {
  const BuildPrivacyPolicy({super.key});

  @override
  State<BuildPrivacyPolicy> createState() => _BuildPrivacyPolicyState();
}

class _BuildPrivacyPolicyState extends State<BuildPrivacyPolicy> {
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    // init size (375 × 812)
    AppConstants.initSize(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _agreedToTerms,
          onChanged: (value) =>
              setState(() => _agreedToTerms = value!),
          activeColor: const Color(0xFFDC2626),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: const VisualDensity(
            horizontal: -4, // ثابت (سلوك)
            vertical: -4,   // ثابت (سلوك)
          ),
        ),

        SizedBox(
          width: AppConstants.w * 0.0213, // 8 / 375
        ),

        _buildPolicyText(),
      ],
    );
  }

  Widget _buildPolicyText() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          top: AppConstants.h * 0.0025, // 2 / 812
        ),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: AppConstants.w * 0.032, // 12 / 375
              color: const Color(0xFF6B7280),
              height: 1.4, // line-height (نسبة)
            ),
            children: [
              TextSpan(
                text: 'I agree to the ',
                style: AppTextStyles.titleMedium().copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Terms and Conditions',
                style: AppTextStyles.titleMedium().copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                ),
              ),
              TextSpan(
                text: ' & ',
                style: AppTextStyles.titleMedium().copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Privacy policy',
                style: AppTextStyles.titleMedium().copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
