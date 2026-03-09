import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_constants.dart';

class PasswordRequirementsWidget extends StatelessWidget {
  const PasswordRequirementsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppConstants.w * 0.04),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF), // Light blue background
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Password Requirements:',
            style: TextStyle(
              color: Color(0xFF1E40AF), // Dark blue
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          SizedBox(height: AppConstants.h * 0.01),
          _buildRequirementItem('At least 8 characters'),
          _buildRequirementItem('Uppercase (A-Z) & Lowercase (a-z)'),
          _buildRequirementItem('Number (0-9)'),
          _buildRequirementItem('Special char (!@#\$)'),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              color: Color(0xFF2563EB), // Blue
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF2563EB), // Blue
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
