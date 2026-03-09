import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_texts.dart';
import '../utils/app_constants.dart';
import '../utils/app_images.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final bool isPassword;
  final FormFieldValidator<String>? validator;
  final String? prefixImage;
  final bool readOnly;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.prefixImage,
    this.isPassword = false,
    this.readOnly = false,
    this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _obscureNotifier = ValueNotifier(true);
  final ValueNotifier<String?> _errorNotifier = ValueNotifier(null);

  @override
  void dispose() {
    _focusNode.dispose();
    _obscureNotifier.dispose();
    _errorNotifier.dispose();
    super.dispose();
  }

  void _validateImmediately(String? value) {
    _errorNotifier.value = widget.validator?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ================= INPUT =================
        ValueListenableBuilder<String?>(
          valueListenable: _errorNotifier,
          builder: (context, errorText, _) {
            return Container(
              width: AppConstants.w * 0.872,
              constraints: BoxConstraints(minHeight: AppConstants.h * 0.0565),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: errorText != null
                      ? Colors.red
                      : const Color(0xFFE5E7EB),
                ),
              ),
              child: ValueListenableBuilder<bool>(
                valueListenable: _obscureNotifier,
                builder: (context, obscure, _) {
                  return TextFormField(
                    focusNode: _focusNode,
                    controller: widget.controller,
                    keyboardType: widget.keyboardType,
                    obscureText: widget.isPassword && obscure,
                    readOnly: widget.readOnly,
                    textAlignVertical: TextAlignVertical.center,
                    validator: (value) {
                      _validateImmediately(value);
                      return widget.validator?.call(value);
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: _validateImmediately,
                    style: AppTextStyles.titleMedium().copyWith(
                      color: const Color(0xFF463732),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorStyle: const TextStyle(height: 0, fontSize: 0),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppConstants.w * 0.0426,
                        vertical:
                            (AppConstants.h * 0.0565 -
                                (AppConstants.w * 0.032)) /
                            2,
                      ),
                      hintText: widget.hint,
                      hintStyle: TextStyle(
                        color: const Color(0xFFE3E9ED),
                        fontSize: AppConstants.w * 0.032,
                        height: 1.0, // Ensure no extra height from line heights
                      ),
                      prefixIcon: widget.prefixImage != null
                          ? Container(
                              width: AppConstants.w * 0.12,
                              height: AppConstants.h * 0.0565,
                              alignment: Alignment.center,
                              child: Image.asset(
                                widget.prefixImage!,
                                width: AppConstants.w * 0.06,
                                height: AppConstants.w * 0.06,
                                color: const Color(0xFF9CA4AB),
                              ),
                            )
                          : widget.prefixIcon != null
                          ? Icon(
                              widget.prefixIcon,
                              size: AppConstants.w * 0.064,
                              color: const Color(0xFF9CA4AB),
                            )
                          : null,
                      suffixIcon: widget.isPassword
                          ? Padding(
                              padding: EdgeInsets.zero,
                              child: _PasswordToggle(
                                obscureNotifier: _obscureNotifier,
                              ),
                            )
                          : null,
                    ),
                  );
                },
              ),
            );
          },
        ),

        /// ================= ERROR =================
        ValueListenableBuilder<String?>(
          valueListenable: _errorNotifier,
          builder: (context, errorText, _) {
            return AnimatedSize(
              duration: const Duration(milliseconds: 200),
              child: errorText != null
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: AppConstants.h * 0.0074,
                        left: AppConstants.w * 0.032,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: AppConstants.w * 0.0373,
                            color: Colors.red,
                          ),
                          SizedBox(width: AppConstants.w * 0.0106),
                          Expanded(
                            child: Text(
                              errorText,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: AppConstants.w * 0.032,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            );
          },
        ),
      ],
    );
  }
}

/// ================= PASSWORD TOGGLE =================
class _PasswordToggle extends StatelessWidget {
  final ValueNotifier<bool> obscureNotifier;

  const _PasswordToggle({required this.obscureNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureNotifier,
      builder: (context, obscure, _) {
        return IconButton(
          onPressed: () => obscureNotifier.value = !obscureNotifier.value,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: obscure
              ? Image.asset(
                  AppImages.eyeslash,
                  width: AppConstants.w * 0.052,
                  height: AppConstants.w * 0.052,
                )
              : Icon(
                  Icons.visibility_outlined,
                  size: AppConstants.w * 0.053,
                  color: const Color(0xFF9CA4AB),
                ),
        );
      },
    );
  }
}
