import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_constants.dart';

class PasswordRequirementsWidget extends StatelessWidget {
  final String password;

  const PasswordRequirementsWidget({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    // Define requirements
    final List<Map<String, dynamic>> requirements = [
      {'text': 'At least 8 characters', 'isMet': password.length >= 8},
      {
        'text': 'At least one uppercase letter (A-Z)',
        'isMet': RegExp(r'[A-Z]').hasMatch(password),
      },
      {
        'text': 'At least one lowercase letter (a-z)',
        'isMet': RegExp(r'[a-z]').hasMatch(password),
      },
      {
        'text': 'At least one number (0-9)',
        'isMet': RegExp(r'[0-9]').hasMatch(password),
      },
      {
        'text': 'At least one special character (!@#\$&*~)',
        'isMet': RegExp(r'[!@#\$&*~]').hasMatch(password),
      },
    ];

    // Calculate progress
    final int metCount = requirements
        .where((req) => req['isMet'] as bool)
        .length;
    final double progress = metCount / requirements.length;

    // Colors
    final Color progressColor = progress == 1.0
        ? Colors.green
        : (progress > 0.5 ? Colors.orange : Colors.red);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppConstants.h * 0.01),

        // Progress Bar
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFFE5E7EB),
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            minHeight: AppConstants.h * 0.008,
          ),
        ),

        SizedBox(height: AppConstants.h * 0.015),

        // Checklist
        ...requirements.map(
          (req) => _buildRequirementItem(
            req['text'] as String,
            req['isMet'] as bool,
          ),
        ),
      ],
    );
  }

  Widget _buildRequirementItem(String text, bool isMet) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppConstants.h * 0.005),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.circle_outlined,
            size: AppConstants.w * 0.04,
            color: isMet ? Colors.green : const Color(0xFF9CA4AB),
          ),
          SizedBox(width: AppConstants.w * 0.02),
          Text(
            text,
            style: TextStyle(
              fontSize: AppConstants.w * 0.03,
              color: isMet ? const Color(0xFF111111) : const Color(0xFF9CA4AB),
              fontWeight: isMet ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
