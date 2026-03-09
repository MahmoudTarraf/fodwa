// ignore_for_file: unused_local_variable

import 'package:easy_localization/easy_localization.dart';

import '../../generated/locale_keys.g.dart';

class Validator {
  static bool isValidEmail(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    return regex.hasMatch(email);
  }

  static String? validateEmail(String? value) {
    bool isValidGmail = isValidEmail(value ?? "");

    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.Validations_Auth_email_required.tr();
    }
    if (isValidGmail == false) {
      return LocaleKeys.Validations_Auth_email_invalid.tr();
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.Validations_Auth_field_required.tr();
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Password must contain at least one uppercase letter (A-Z)";
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Password must contain at least one lowercase letter (a-z)";
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Password must contain at least one number (0-9)";
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      return "Password must contain at least one special character (!@#\$&*~)";
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.length < 8) {
      return LocaleKeys.Validations_Auth_password_invalid.tr();
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }

  static String? validateIraqPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.Validations_Auth_phone_required.tr();
    }

    final cleaned = value.replaceAll(RegExp(r'\s+'), '');

    // يقبل أرقام فقط مع + في الأول (اختياري)
    final regex = RegExp(r'^\+?\d{7,15}$');

    return null;
  }

  static String? validateField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.Validations_Auth_field_required.tr();
    }
    return null;
  }

  static bool isValidPhone(String phone) {
    final regex = RegExp(r'^(?:\+?\d{1,3})?\d{10,15}$');
    return regex.hasMatch(phone);
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.Validations_Auth_phone_required.tr();
    }

    if (!isValidPhone(value.trim())) {
      return LocaleKeys.Validations_Auth_phone_invalid.tr();
    }

    return null;
  }
}
