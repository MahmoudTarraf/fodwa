// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fodwa/core/utils/responsive_helper.dart';

class CustomTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final int? maxLength;
  final EdgeInsets? contentPadding;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final bool enableSuggestions;
  final bool autocorrect;

  const CustomTextField({
    Key? key,
    this.label,
    this.hint,
    this.controller,
    this.focusNode,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.contentPadding,
    this.autofocus = false,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.enableSuggestions = true,
    this.autocorrect = true,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  final ValueNotifier<String?> _errorNotifier = ValueNotifier(null);
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _errorNotifier.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _validateImmediately(String? value) {
    if (widget.validator != null) {
      final error = widget.validator!(value);
      _errorNotifier.value = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate dynamic height based on maxLines
    final double baseHeight = widget.maxLines == 1
        ? 44
        : (widget.maxLines * 28) + 24;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Input Field
        ValueListenableBuilder<String?>(
          valueListenable: _errorNotifier,
          builder: (context, errorText, _) {
            return Material(
              color: Colors.white,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: errorText != null
                      ? Colors.redAccent
                      : const Color(0xFFD1D8DD),
                  width: 1,
                ),
              ),
              child: SizedBox(
                width: ResponsiveHelper.proportionalWidth(context, 327),
                height: baseHeight,
                child: TextFormField(
                  focusNode: _focusNode,
                  controller: widget.controller,
                  validator: (value) {
                    _validateImmediately(value);
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  textInputAction: widget.textInputAction,
                  onTap: widget.onTap,
                  onChanged: (value) {
                    _validateImmediately(value);
                    widget.onChanged?.call(value);
                  },
                  onFieldSubmitted: widget.onFieldSubmitted,
                  enabled: widget.enabled,
                  readOnly: widget.readOnly,
                  maxLines: widget.maxLines,
                  maxLength: widget.maxLength,
                  autofocus: widget.autofocus,
                  inputFormatters: widget.inputFormatters,
                  textCapitalization: widget.textCapitalization,
                  enableSuggestions: widget.enableSuggestions,
                  autocorrect: widget.autocorrect,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: widget.enabled
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorStyle: const TextStyle(height: 0, fontSize: 0),
                    hintText: widget.hint,
                    hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.5),
                    ),
                    prefixIcon: widget.prefixIcon != null
                        ? IconTheme(
                            data: IconThemeData(
                              color: widget.enabled
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.7)
                                  : Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.4),
                            ),
                            child: widget.prefixIcon!,
                          )
                        : null,
                    suffixIcon: widget.suffixIcon != null
                        ? IconTheme(
                            data: IconThemeData(
                              color: widget.enabled
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.7)
                                  : Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.4),
                            ),
                            child: widget.suffixIcon!,
                          )
                        : null,
                    contentPadding:
                        widget.contentPadding ??
                        EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: widget.maxLines == 1 ? 12 : 2,
                        ),
                    counterText: widget.maxLength != null ? null : "",
                  ),
                ),
              ),
            );
          },
        ),

        // Error Message Display
        ValueListenableBuilder<String?>(
          valueListenable: _errorNotifier,
          builder: (context, errorText, _) {
            return AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              child: errorText != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 6, left: 12),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 14,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              errorText,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 12,
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
