// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> _ar = {
    "auth": {
      "welcomeBack": "مرحبًا بعودتك!",
      "enterInfoToAccess": "أدخل البيانات التالية للوصول إلى حسابك",
      "email": "البريد الإلكتروني",
      "phone": "الهاتف",
      "password": "كلمة المرور",
      "rememberMe": "تذكرني",
      "forgotPassword": "نسيت كلمة المرور؟",
      "login": "تسجيل الدخول",
      "continueAsGuest": "المتابعة كضيف",
      "dontHaveAccount": "ليس لديك حساب؟",
      "signUp": "إنشاء حساب",
      "phoneNumber": "رقم الهاتف",
      "forgotPasswordTitle": "نسيت كلمة المرور",
      "enterEmailForReset":
          "أدخل بريدك الإلكتروني للحصول على رمز إعادة التعيين",
      "send": "إرسال",
      "email_example": "example@ggmail.com",
      "or": "أو",
      "signUpToFodwa": "إنشاء حساب في فودوا",
      "enterDetailsBelow": "أدخل بياناتك أدناه",
      "addBannerHint": "أضف صورة بانر بالأبعاد المثالية 3200 × 410 بكسل.",
      "fullName": "الاسم الكامل *",
      "country": "الدولة *",
      "city": "المدينة",
      "street": "الشارع",
      "buildingNumber": "رقم المبنى",
      "apartmentNumber": "رقم الشقة",
      "accountType": "نوع الحساب *",
      "choose": "اختر",
      "aboutMe": "نبذة عني",
      "agreeTerms": "أوافق على الشروط والأحكام وسياسة الخصوصية",
      "alreadyHaveAccount": "لديك حساب بالفعل؟",
      "verifyCode": "تأكيد الرمز",
      "enterVerificationCode":
          "أدخل الرمز الذي تم إرساله إلى بريدك الإلكتروني للتحقق من هويتك",
      "resendCode": "إعادة إرسال الرمز",
      "resendIn": "إعادة الإرسال خلال",
      "sendCodeAgain": "إرسال الرمز مرة أخرى",
      "resetPassword": "إعادة تعيين كلمة المرور",
      "createNewPassword": "أنشئ كلمة مرور جديدة",
      "confirmPassword": "تأكيد كلمة المرور",
      "congratulations": "تهانينا",
      "passwordUpdated": "تم تحديث كلمة المرور بنجاح",
    },
    "Validations": {
      "Passwords_do_not_match": "كلمتا المرور غير متطابقتين",
      "Auth_email_required": "البريد الإلكتروني مطلوب",
      "Auth_email_invalid": "صيغة البريد الإلكتروني غير صحيحة",
      "Auth_password_invalid": "يجب أن تكون كلمة المرور 8 أحرف على الأقل",
      "Auth_field_required": "هذا الحقل لا يجب أن يكون فارغًا",
      "Auth_phone_required": "رقم الهاتف مطلوب",
      "Validations_description_min_length": "الوصف يجب أن لا يقل عن 5 أحرف",
      "enterYourMaterial": "أدخل المادة",
      "enterWeight": "أدخل الوزن",
      "chooseVehicle": "اختر المركبة",
      "enterBudget": "أدخل الميزانية",
      "Auth_phone_invalid": "رقم الهاتف غير صحيح",
    },
  };
  static const Map<String, dynamic> _en = {
    "auth": {
      "welcomeBack": "Welcome back!",
      "enterInfoToAccess":
          "Enter the following information to access your account!",
      "email": "E-Mail",
      "phone": "Phone",
      "password": "Password",
      "rememberMe": "Remember me",
      "forgotPassword": "Forgot Password",
      "login": "Login",
      "continueAsGuest": "Continue as a Guest",
      "dontHaveAccount": "You don’t have an account?",
      "signUp": "Sign up",
      "email_example": "example@ggmail.com",
      "phoneNumber": "Phone Number",
      "or": "OR",
      "signUpToFodwa": "Sign Up to FODWA",
      "enterDetailsBelow": "Enter your details below",
      "addBannerHint":
          "Add a banner image with ideal dimensions of 3200 × 410 pixels.",
      "fullName": "Full Name *",
      "country": "Country *",
      "city": "City",
      "street": "Street",
      "buildingNumber": "Building number",
      "apartmentNumber": "Apartment number",
      "accountType": "Account type *",
      "choose": "Choose",
      "aboutMe": "About me",
      "agreeTerms": "I agree to the Terms & Conditions and Privacy Policy",
      "alreadyHaveAccount": "You already have an account?",
      "forgotPasswordTitle": "Forgot Password",
      "enterEmailForReset": "Enter your email to get a reset code.",
      "send": "Send",
      "verifyCode": "Verify Code",
      "enterVerificationCode":
          "Enter the code sent to your email to verify your identity",
      "resendCode": "Resend the code",
      "resendIn": "Resend the code in",
      "sendCodeAgain": "Send code again",
      "resetPassword": "Reset Password",
      "createNewPassword": "Create a new password.",
      "confirmPassword": "Confirm Password",
      "congratulations": "Congratulations",
      "passwordUpdated": "Your password has been updated",
    },
    "Validations": {
      "Passwords_do_not_match": "Passwords do not match",
      "enterYourMaterial": "Enter your material",
      "enterWeight": "Enter weight",
      "chooseVehicle": "Choose vehicle",
      "enterBudget": "Enter budget",
      "Auth_email_required": "Email is required",
      "Auth_email_invalid": "Invalid email format",
      "Auth_password_invalid": "Password must be at least 8 characters",
      "Auth_field_required": "This field cannot be empty",
      "Auth_phone_required": "Phone number is required",
      "Auth_phone_invalid": "Invalid phone number",
      "Validations_description_min_length":
          "Description must be at least 5 characters",
    },
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "ar": _ar,
    "en": _en,
  };
}
