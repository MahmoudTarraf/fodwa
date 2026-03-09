import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_constants.dart';

// ignore: must_be_immutable
class QuickQuestionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  double? width;

  QuickQuestionButton({
    Key? key,
    this.width,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // init size (375 × 812)
    AppConstants.initSize(context);

    return Material(
      borderRadius: BorderRadius.circular(
        AppConstants.w * 0.053, // 20 / 375
      ),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          AppConstants.w * 0.053, // 20 / 375
        ),
        child: Container(
          width: width != null
              ? AppConstants.w *
                    (width! / 375) // dynamic width / 375
              : AppConstants.w * 0.341, // 128 / 375
          height: AppConstants.h * 0.046, // 37 / 812
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.w * 0.043, // 16 / 375
            vertical: AppConstants.h * 0.012, // 10 / 812
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFfdfdfd),
            borderRadius: BorderRadius.circular(
              AppConstants.w * 0.053, // 20 / 375
            ),
            border: Border.all(
              color: const Color(0xFFECF1F6),
              width: AppConstants.w * 0.0027, // 1 / 375
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: AppConstants.w * 0.032, // 12 / 375
                color: const Color(0xFF171725),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
