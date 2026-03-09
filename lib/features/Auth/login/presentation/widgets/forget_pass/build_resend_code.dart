import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_constants.dart';

class BuildResendCode extends StatefulWidget {
  const BuildResendCode({super.key});

  @override
  State<BuildResendCode> createState() => _BuildResendCodeState();
}

class _BuildResendCodeState extends State<BuildResendCode> {
  int _remainingSeconds = 120; // 2 minutes = 120 seconds
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Resend the code in ",
            style: TextStyle(
              color: const Color(0xFF66707A),
              fontWeight: FontWeight.w400,
              fontSize: AppConstants.w * 0.032, // 12 / 375
            ),
          ),
          Text(
            _formatTime(_remainingSeconds),
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w400,
              fontSize: AppConstants.w * 0.032, // 12 / 375
            ),
          ),
        ],
      ),
    );
  }
}
