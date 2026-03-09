import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../../../../core/utils/app_constants.dart'
    show StaticList, AppConstants;
import '../../../../../../../core/utils/app_validator.dart';
import 'phone_design_const.dart';

class BuildPhoneNumber extends StatefulWidget {
  final TextEditingController? controller;
  final void Function(String number, String isoCode)? onChanged;
  final FormFieldValidator<String>? validator;
  final String? isoCode;
  final bool enabled;

  const BuildPhoneNumber({
    super.key,
    this.controller,
    this.onChanged,
    this.validator,
    this.isoCode,
    this.enabled = true,
  });

  @override
  State<BuildPhoneNumber> createState() => _BuildPhoneNumberState();
}

class _BuildPhoneNumberState extends State<BuildPhoneNumber> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  final ValueNotifier<bool> _focusNotifier = ValueNotifier(false);
  final ValueNotifier<String?> _errorNotifier = ValueNotifier(null);

  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'SA');

  // Track the last number and iso we reported to parent to avoid redundant updates.
  String? _lastReportedNumber;
  String? _lastReportedIso;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    _focusNode.addListener(() {
      _focusNotifier.value = _focusNode.hasFocus;
    });

    _phoneNumber = PhoneNumber(isoCode: widget.isoCode ?? 'SA');
  }

  @override
  void didUpdateWidget(BuildPhoneNumber oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isoCode != oldWidget.isoCode &&
        widget.isoCode != null &&
        widget.isoCode != _phoneNumber.isoCode) {
      // Synchronously update _phoneNumber to be used in the current build.
      // If the subscriber number is empty, we must use null to avoid 'notANumber' exception in some library versions.
      final String? currentNumber =
          (_phoneNumber.phoneNumber != null &&
              _phoneNumber.phoneNumber!.isNotEmpty)
          ? _phoneNumber.phoneNumber
          : null;

      _phoneNumber = PhoneNumber(
        isoCode: widget.isoCode!,
        phoneNumber: currentNumber,
      );
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _focusNotifier.dispose();
    _errorNotifier.dispose();

    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _focusNotifier,
      child: Stack(
        alignment: Alignment.center,
        children: [_buildPhoneInput(context)],
      ),
      builder: (context, isFocused, phoneStack) {
        return ValueListenableBuilder<String?>(
          valueListenable: _errorNotifier,
          child: phoneStack,
          builder: (context, errorText, staticChild) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: AppConstants.w * 0.872,
                  constraints: BoxConstraints(minHeight: AppConstants.h * 0.065),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: errorText != null
                          ? Colors.red
                          : (isFocused
                                ? const Color(0xFFCE1126)
                                : const Color(0xFFF3F4F6)),
                      width: 1.5,
                    ),
                  ),
                  child: staticChild,
                ),
                if (errorText != null) _buildErrorWidget(errorText),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildErrorWidget(String errorText) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      child: Padding(
        padding: EdgeInsets.only(
          top: AppConstants.h * 0.007,
          left: AppConstants.w * 0.032,
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, size: 14, color: Colors.red),
            SizedBox(width: AppConstants.w * 0.011),
            Expanded(
              child: Text(
                errorText,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.w * 0.01),
      child: InternationalPhoneNumberInput(
        focusNode: _focusNode,
        textFieldController: _controller,
        initialValue: _phoneNumber,
        locale: context.locale.languageCode,
        isEnabled: widget.enabled,
        textAlign: TextAlign.start,
        textStyle: TextStyle(
          fontSize: AppConstants.w * 0.038, // 14 / 375
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),

        onInputChanged: _onPhoneChanged,

        validator: (value) {
          return widget.validator?.call(value) ??
              Validator.validatePhone(value);
        },
        onInputValidated: (isValid) {
          // This is a safer place to check for cumulative validation if needed
          // but for now, we rely on the Form validator.
          // We can set _errorNotifier here if we want real-time error text update.
          if (isValid) {
            _errorNotifier.value = null;
          }
        },

        selectorConfig: PhoneDesignConsts.selectorConfig,

        selectorTextStyle: PhoneDesignConsts.selectorTextStyle,

        inputDecoration: _inputDecoration,
        searchBoxDecoration: _searchDecoration,

        keyboardType: TextInputType.number,
        autoValidateMode: AutovalidateMode.disabled,

        spaceBetweenSelectorAndTextField: 0,

        countrySelectorScrollControlled: true,
        countries: StaticList.supportedCountries,
      ),
    );
  }

  void _onPhoneChanged(PhoneNumber number) {
    final fullNumber = number.phoneNumber ?? '';
    final iso = number.isoCode ?? 'SA';

    if (fullNumber == _lastReportedNumber && iso == _lastReportedIso) {
      return;
    }

    _lastReportedNumber = fullNumber;
    _lastReportedIso = iso;

    // IMPORTANT: Do NOT update _phoneNumber here.
    // _phoneNumber is used as initialValue for the library widget.
    // Updating it causes the library to call initialiseWidget() in its didUpdateWidget(),
    // which leads to the 47-second ANR during typing.

    widget.onChanged?.call(fullNumber, iso);
  }

  InputDecoration get _inputDecoration => InputDecoration(
    hintText: '598 789 458',
    hintStyle: TextStyle(
      fontSize: AppConstants.w * 0.032,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFE3E9ED),
    ),
    isDense: true,
    border: InputBorder.none,
    errorText: null,
    errorStyle: const TextStyle(fontSize: 0),
  );

  InputDecoration get _searchDecoration => InputDecoration(
    hintText: 'Search country...',
    prefixIcon: Container(
      width: AppConstants.w * 0.08,
      height: AppConstants.h * 0.04,
      alignment: Alignment.center,
      child: Icon(
        Icons.search_rounded,
        size: AppConstants.w * 0.06,
        color: Colors.grey,
      ),
    ),
    filled: true,
    fillColor: const Color(0xFFF9FAFB),
    border: PhoneDesignConsts.outlineBorder,
    enabledBorder: PhoneDesignConsts.outlineBorder,
    focusedBorder: PhoneDesignConsts.focusedBorder,
    contentPadding: EdgeInsets.symmetric(
      horizontal: AppConstants.w * 0.043,
      vertical: AppConstants.h * 0.017,
    ),
  );
}
