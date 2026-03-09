import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/features/Auth/login/domain/use_cases/forget_password_use_case.dart';
import 'package:fodwa/features/Auth/login/domain/use_cases/login_use_case.dart';
import 'package:fodwa/features/Auth/signUp/domain/use_cases/verify_registration_use_case.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:fodwa/features/Auth/login/presentation/bloc/loginEvents.dart';
import 'package:fodwa/features/Auth/login/presentation/bloc/login_states.dart';
import 'package:fodwa/features/Auth/login/data/models/loginModel.dart';
import 'package:fodwa/features/profile/domain/use_cases/upload_profile_image_use_case.dart';
import 'package:fodwa/core/session/session_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final VerifyRegistrationUseCase verifyRegistrationUseCase;
  final UploadProfileImageUseCase? uploadProfileImageUseCase;

  LoginBloc({
    required this.loginUseCase,
    required this.forgetPasswordUseCase,
    required this.verifyRegistrationUseCase,
    this.uploadProfileImageUseCase,
  }) : super(LoginInitial()) {
    on<ChangeLoginTab>(_onChangeLoginTab);
    on<SetRemember>(_onSetRemember);
    on<UpdatePhoneNumber>(_onUpdatePhoneNumber);
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<SocialLoginButtonPressed>(_onSocialLoginButtonPressed);
    on<ForgetPasswordPressed>(_onForgetPasswordPressed);
    on<CodeVerify>(_onVerifyCode);
    on<CreateNewPassEvent>(createNewPass);
    on<VerifyRegistrationOtp>(_onVerifyRegistrationOtp);
    on<ResetLoginState>((event, emit) {
      emit(
        LoginInitial(
          isRemember: state.isRemember,
          selectedTab: state.selectedTab,
          phoneNumber: state.phoneNumber,
        ),
      );
    });
  }

  void _onChangeLoginTab(ChangeLoginTab event, Emitter<LoginState> emit) {
    emit(state.copyWith(selectedTab: event.index));
  }

  void _onSetRemember(SetRemember event, Emitter<LoginState> emit) {
    emit(state.copyWith(isRemember: event.isRemember));
  }

  void _onUpdatePhoneNumber(UpdatePhoneNumber event, Emitter<LoginState> emit) {
    emit(
      PhoneNumberUpdated(
        isRemember: state.isRemember,
        selectedTab: state.selectedTab,
        phoneNumber: event.phoneNumber,
      ),
    );
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    final model = LoginModel(
      email: event.model.email,
      phone: event.model.phone,
      password: event.model.password,
      rememberMe: state.isRemember,
    );
    emit(
      LoginLoading(
        isRemember: state.isRemember,
        selectedTab: state.selectedTab,
        phoneNumber: state.phoneNumber,
      ),
    );
    final result = await loginUseCase.login(model);
    if (result.isSuccess) {
      emit(
        LoginSuccess(
          isRemember: state.isRemember,
          selectedTab: state.selectedTab,
          phoneNumber: state.phoneNumber,
        ),
      );
    } else {
      String errorMessage = result.error.toString();
      final String lowerError = errorMessage.toLowerCase();
      
      // Use a generic error message for any credential-related failure
      // to avoid leaking info about whether email or password was wrong
      if (lowerError.contains('password') || lowerError.contains('كلمة المرور') || 
          lowerError.contains('credentials') || lowerError.contains('user') || 
          lowerError.contains('مستخدم') || lowerError.contains('account') ||
          lowerError.contains('email') || lowerError.contains('بريد') ||
          lowerError.contains('invalid')) {
        errorMessage = "auth.wrongCredentials".tr();
      }

      emit(
        LoginFailure(
          errorMessage,
          isRemember: state.isRemember,
          selectedTab: state.selectedTab,
          phoneNumber: state.phoneNumber,
        ),
      );
    }
  }

  Future<void> _onSocialLoginButtonPressed(
    SocialLoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      LoginLoading(
        isRemember: state.isRemember,
        selectedTab: state.selectedTab,
        phoneNumber: state.phoneNumber,
      ),
    );
    final result = await loginUseCase.login_with_social(event.model);
    if (result.isSuccess) {
      emit(
        LoginSuccess(
          isRemember: state.isRemember,
          selectedTab: state.selectedTab,
          phoneNumber: state.phoneNumber,
        ),
      );
    } else {
      emit(
        LoginFailure(
          result.error.toString(),
          isRemember: state.isRemember,
          selectedTab: state.selectedTab,
          phoneNumber: state.phoneNumber,
        ),
      );
    }
  }

  Future<void> _onForgetPasswordPressed(
    ForgetPasswordPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      ForgetEmailPassLoading(
        isRemember: state.isRemember,
        selectedTab: state.selectedTab,
        phoneNumber: state.phoneNumber,
      ),
    );
    final result = await forgetPasswordUseCase.sendResetCode(
      email: event.email,
      phone: event.phone,
    );
    if (result.isSuccess) {
      emit(
        SendEmailSuccess(
          isRemember: state.isRemember,
          selectedTab: state.selectedTab,
          email: event.email,
          phoneNumber: event.phone != null
              ? PhoneNumber(
                  phoneNumber: event.phone,
                  isoCode: state.phoneNumber.isoCode,
                )
              : state.phoneNumber,
        ),
      );
    } else {
      emit(
        SendEmailFailure(
          result.error.toString(),
          isRemember: state.isRemember,
          selectedTab: state.selectedTab,
          phoneNumber: state.phoneNumber,
        ),
      );
    }
  }

  Future<void> _onVerifyCode(CodeVerify event, Emitter<LoginState> emit) async {
    emit(
      ForgetEmailPassLoading(
        isRemember: state.isRemember,
        selectedTab: state.selectedTab,
        email: event.email,
        phoneNumber: state.phoneNumber,
      ),
    );
    final result = await forgetPasswordUseCase.verifyCode(
      email: event.email,
      phone: event.phone,
      code: event.code,
    );
    if (result.isSuccess) {
      emit(
        VerifiedSuccess(
          isRemember: state.isRemember,
          selectedTab: state.selectedTab,
          email: event.email,
          phoneNumber: event.phone != null
              ? PhoneNumber(
                  phoneNumber: event.phone,
                  isoCode: state.phoneNumber.isoCode,
                )
              : state.phoneNumber,
        ),
      );
    } else {
      emit(
        VerifyFailure(
          result.error.toString(),
          isRemember: state.isRemember,
          selectedTab: state.selectedTab,
          email: event.email,
          phoneNumber: event.phone != null
              ? PhoneNumber(
                  phoneNumber: event.phone,
                  isoCode: state.phoneNumber.isoCode,
                )
              : state.phoneNumber,
        ),
      );
    }
  }

  Future<void> createNewPass(
    CreateNewPassEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      ForgetEmailPassLoading(
        isRemember: state.isRemember,
        selectedTab: state.selectedTab,
        email: event.email,
        phoneNumber: event.phone != null
            ? PhoneNumber(
                phoneNumber: event.phone,
                isoCode: state.phoneNumber.isoCode,
              )
            : state.phoneNumber,
      ),
    );
    final result = await forgetPasswordUseCase.resetPassword(
      email: event.email,
      phone: event.phone,
      code: event.code,
      password: event.pass,
      confirmPassword: event.confirmPass,
    );
    if (result.isSuccess) {
      emit(
        PasswordCreatedSuccess(
          isRemember: state.isRemember,
          selectedTab: state.selectedTab,
          phoneNumber: state.phoneNumber,
        ),
      );
    } else {
      emit(
        PassCreatedFailure(
          result.error.toString(),
          isRemember: state.isRemember,
          selectedTab: state.selectedTab,
          phoneNumber: state.phoneNumber,
        ),
      );
    }
  }

  Future<void> _onVerifyRegistrationOtp(
    VerifyRegistrationOtp event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      ForgetEmailPassLoading(
        isRemember: state.isRemember,
        selectedTab: state.selectedTab,
        email: event.email,
        phoneNumber: state.phoneNumber,
      ),
    );
    final result = await verifyRegistrationUseCase(
      email: event.email,
      code: event.code,
    );
    if (result.isSuccess) {
      // Upload profile image if available
      if (uploadProfileImageUseCase != null &&
          event.profileImagePath != null &&
          event.profileImagePath!.isNotEmpty) {
        try {
          String? token;
          String? userId;

          if (result.data is Map<String, dynamic>) {
            token =
                result.data['token'] as String? ??
                result.data['access'] as String?;
            if (result.data['user'] != null &&
                result.data['user'] is Map<String, dynamic>) {
              userId = result.data['user']['id']?.toString();
            }

            if (token != null && userId != null) {
              debugPrint('*** Uploading Profile Image After Verification ***');
              await SessionManager.saveSession(token: token, userId: userId);
              await uploadProfileImageUseCase!(event.profileImagePath!);
              debugPrint('*** Profile Image Upload Request Sent ***');
            }
          }
        } catch (e) {
          debugPrint('Profile image upload failed during verification: $e');
        }
      }

      emit(
        RegistrationVerifiedSuccess(
          isRemember: state.isRemember,
          selectedTab: state.selectedTab,
          email: event.email,
          phoneNumber: state.phoneNumber,
        ),
      );
    } else {
      emit(
        VerifyFailure(
          result.error.toString(),
          isRemember: state.isRemember,
          selectedTab: state.selectedTab,
          email: event.email,
          phoneNumber: state.phoneNumber,
        ),
      );
    }
  }
}
