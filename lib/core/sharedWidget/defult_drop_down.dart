import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../utils/app_constants.dart';
import '../utils/app_texts.dart';

/// REFERENCE: 375 x 812
class DefaultDropdown<T> extends StatelessWidget {
  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final T? value;
  final IconData? prefixIcon;

  const DefaultDropdown({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.validator,
    this.value,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      /// 327 / 375
      width: AppConstants.w * 0.872,
      constraints: BoxConstraints(minHeight: AppConstants.h * 0.054),

      child: Material(
        color: Colors.white,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: const Color(0xFFE5E7EB), width: 1),
        ),
        child: DropdownButtonFormField2<T>(
          isExpanded: true,
          value: value,
          items: items,
          onChanged: onChanged,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,

          /// text after selection
          style: AppTextStyles.titleMedium().copyWith(
            color: Colors.black,
            fontSize: AppConstants.w * 0.037,
          ),

          /// hint
          hint: Text(
            hintText,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: const Color(0xFFE3E9ED),
              fontSize: AppConstants.w * 0.032,
            ),
          ),

          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,

            contentPadding: EdgeInsets.symmetric(
              vertical: AppConstants.h * 0.010,
            ),

            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,

                    /// 24 / 375
                    size: AppConstants.w * 0.064,
                    color: const Color(0xFF9CA4AB),
                  )
                : null,

            enabledBorder: OutlineInputBorder(
              /// 8 / 375
              borderRadius: BorderRadius.circular(AppConstants.w * 0.0213),
              borderSide: const BorderSide(color: Color(0xFFD1D8DD), width: 1),
            ),

            focusedBorder: OutlineInputBorder(
              /// 8 / 375
              borderRadius: BorderRadius.circular(AppConstants.w * 0.0213),
              borderSide: const BorderSide(color: Color(0xFFD1D8DD), width: 1),
            ),

            focusedErrorBorder: OutlineInputBorder(
              /// 14 / 375
              borderRadius: BorderRadius.circular(AppConstants.w * 0.0373),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
            ),
          ),

          iconStyleData: IconStyleData(
            icon: _buildIcon(Icons.keyboard_arrow_down),
            openMenuIcon: _buildIcon(Icons.keyboard_arrow_up),
          ),

          dropdownStyleData: DropdownStyleData(
            /// 0.3 of height
            maxHeight: AppConstants.h * 0.3,

            /// -10 / 812
            offset: Offset(0, -AppConstants.h * 0.0123),

            decoration: BoxDecoration(
              color: Color(0XFFF5F5F5),

              /// 12 / 375
              borderRadius: BorderRadius.circular(AppConstants.w * 0.032),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.w * 0.032,
        vertical: AppConstants.w * 0.0010,
      ),
      child: Container(
        /// 24 / 375
        width: AppConstants.w * 0.064,

        /// 24 / 375
        height: AppConstants.w * 0.064,

        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFD1D8DD), width: 1),

          /// 6 / 375
          borderRadius: BorderRadius.circular(AppConstants.w * 0.016),
        ),
        child: Icon(
          icon,
          size: AppConstants.h * 0.028,
          color: Color(0XFF66707A),
        ),
      ),
    );
  }
}
