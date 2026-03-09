import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../../../../core/utils/app_constants.dart' show AppConstants;

class PhoneDesignConsts {
  static const SelectorConfig selectorConfig = SelectorConfig(
    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
    showFlags: true,
    useEmoji: true,
    trailingSpace: false,
    leadingPadding: 12,
  );

  static final TextStyle selectorTextStyle = TextStyle(
    fontSize: AppConstants.w * 0.038, // 14 / 375
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0,
    height: 1.2,
  );

  static const TextStyle hintStyle = TextStyle(
    color: Color(0xFF9CA3AF),
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle searchHintStyle = TextStyle(
    color: Color(0xFF9CA3AF),
    fontSize: 15,
  );

  static final OutlineInputBorder outlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
  );

  static final OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Color(0xFFCE1126), width: 1.5),
  );
}
