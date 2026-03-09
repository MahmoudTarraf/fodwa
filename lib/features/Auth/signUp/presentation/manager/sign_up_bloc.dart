import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/features/Auth/signUp/presentation/manager/sign_up_events.dart';
import 'package:fodwa/features/Auth/signUp/presentation/manager/sign_up_states.dart';
import 'package:fodwa/features/profile/domain/use_cases/upload_profile_image_use_case.dart';
import 'package:fodwa/core/session/session_manager.dart';
import 'package:flutter/foundation.dart';

import '../../domain/use_cases/sign_up_use_case.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;
  final UploadProfileImageUseCase? uploadProfileImageUseCase;

  SignUpBloc({required this.signUpUseCase, this.uploadProfileImageUseCase})
    : super(const SignUpInitial()) {
    on<SignUpButtonPressed>(_onSignUpButtonPressed);
    on<SelectCountryEvent>(_onSelectCountryEvent);
    on<SelectCityEvent>(_onSelectCityEvent);
    on<SelectAccountTypeEvent>(_onSelectAccType);

    on<SelectGenderEvent>((event, emit) {
      emit(state.copyWith(gender: event.gender));
    });

    on<SelectGeneralJobEvent>((event, emit) {
      emit(state.copyWith(selectedGeneralJob: event.job));
    });

    on<SelectRelatedJobEvent>((event, emit) {
      emit(state.copyWith(selectedRelatedJob: event.job));
    });
    on<SelectBusinessSectorEvent>((event, emit) {
      emit(state.copyWith(selectedBusinessSector: event.sector));
    });

    on<AddSkillEvent>((event, emit) {
      if (!state.selectedSkills.contains(event.skill)) {
        final updatedSkills = List<String>.from(state.selectedSkills)
          ..add(event.skill);
        emit(state.copyWith(selectedSkills: updatedSkills));
      }
    });

    on<RemoveSkillEvent>((event, emit) {
      final updatedSkills = List<String>.from(state.selectedSkills)
        ..remove(event.skill);
      emit(state.copyWith(selectedSkills: updatedSkills));
    });
    on<AddServiceEvent>(_onAddService);
    on<RemoveServiceEvent>(_onRemoveService);

    // ✅ NEW: Date of Birth Handler
    on<SelectDateOfBirthEvent>((event, emit) {
      emit(state.copyWith(dateOfBirth: event.dateOfBirth));
    });

    on<SelectProfileImageEvent>((event, emit) {
      emit(state.copyWith(profileImagePath: event.imagePath));
    });

    on<SelectBannerImageEvent>((event, emit) {
      emit(state.copyWith(bannerImagePath: event.bannerPath));
    });

    on<UpdatePhoneNumberEvent>((event, emit) {
      emit(
        state.copyWith(
          phoneNumberText: event.phoneNumber,
          isoCode: event.isoCode,
        ),
      );
    });

    on<TogglePolicyEvent>((event, emit) {
      emit(state.copyWith(isPolicyAccepted: event.isAccepted));
    });
  }
  void _onAddService(AddServiceEvent event, Emitter<SignUpState> emit) {
    if (state.selectedServices.contains(event.service)) return;

    emit(
      state.copyWith(
        selectedServices: [...state.selectedServices, event.service],
      ),
    );
  }

  void _onRemoveService(RemoveServiceEvent event, Emitter<SignUpState> emit) {
    emit(
      state.copyWith(
        selectedServices: state.selectedServices
            .where((s) => s != event.service)
            .toList(),
      ),
    );
  }

  void _onSelectCountryEvent(
    SelectCountryEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(
      state.copyWith(
        selectedCountry: event.countryModel,
        selectedCity: null,
        isoCode: event.countryModel.isoCode,
      ),
    );
  }

  void _onSelectCityEvent(SelectCityEvent event, Emitter<SignUpState> emit) {
    emit(state.copyWith(selectedCity: event.cityModel));
  }

  void _onSelectAccType(
    SelectAccountTypeEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(accountType: event.accountType));
  }

  Future<void> _onSignUpButtonPressed(
    SignUpButtonPressed event,
    Emitter<SignUpState> emit,
  ) async {
    final validationResult = signUpUseCase.checkValidation(event.user);

    if (!validationResult.isSuccess) {
      emit(
        SignUpValidationError(
          validationResult.error.toString(),
          selectedCountry: state.selectedCountry,
          selectedCity: state.selectedCity,
          accountType: state.accountType,
          gender: state.gender,
          selectedGeneralJob: state.selectedGeneralJob,
          selectedRelatedJob: state.selectedRelatedJob,
          selectedSkills: state.selectedSkills,
          selectedServices: state.selectedServices,
          dateOfBirth: state.dateOfBirth,
          profileImagePath: state.profileImagePath,
          bannerImagePath: state.bannerImagePath,
          phoneNumberText: state.phoneNumberText,
          isoCode: state.isoCode,
        ),
      );
      return;
    }

    emit(
      SignUpLoading(
        selectedCountry: state.selectedCountry,
        selectedCity: state.selectedCity,
        accountType: state.accountType,
        gender: state.gender,
        selectedBusinessSector: state.selectedBusinessSector,
        selectedGeneralJob: state.selectedGeneralJob,
        selectedRelatedJob: state.selectedRelatedJob,
        selectedSkills: state.selectedSkills,
        selectedServices: state.selectedServices,
        dateOfBirth: state.dateOfBirth,
        profileImagePath: state.profileImagePath,
        bannerImagePath: state.bannerImagePath,
        phoneNumberText: state.phoneNumberText,
        isoCode: state.isoCode,
      ),
    );
    final result = await signUpUseCase(event.user);

    if (result.isSuccess) {
      // Extract message, email, token, and userId from response
      String message = "Account created successfully";
      String? email;
      String? token;
      String? userId;

      try {
        if (result.data is Map<String, dynamic>) {
          message = result.data['message'] as String? ?? message;
          email = result.data['email'] as String?;
          token =
              result.data['token'] as String? ??
              result.data['access'] as String?;

          // Extract userId from user object in response
          if (result.data['user'] != null &&
              result.data['user'] is Map<String, dynamic>) {
            userId = result.data['user']['id']?.toString();
          }
        }
      } catch (e) {
        // If extraction fails, use defaults
        email = event.user.email;
      }

      // Upload profile image if available and token exists
      debugPrint('*** SignUp Success - Checking for Image Upload ***');
      debugPrint('Has Image: ${event.user.profileImage != null}');
      debugPrint('Token: $token');
      debugPrint('UserId: $userId');
      debugPrint('UploadUseCase: $uploadProfileImageUseCase');

      if (uploadProfileImageUseCase != null &&
          event.user.profileImage != null &&
          event.user.profileImage!.isNotEmpty) {
        if (token != null && userId != null) {
          try {
            debugPrint('*** Starting Profile Image Upload ***');
            // Save session for the upload
            await SessionManager.saveSession(token: token, userId: userId);

            // Upload profile image
            await uploadProfileImageUseCase!(event.user.profileImage!);
            debugPrint('*** Profile Image Upload Request Sent ***');
          } catch (e) {
            debugPrint('Profile image upload failed: $e');
          }
        } else {
          debugPrint('*** Skipped Image Upload: Missing Token or UserId ***');
        }
      }

      emit(
        SignUpSuccess(
          message,
          email: email ?? event.user.email,
          profileImagePath: event.user.profileImage,
        ),
      );
    } else {
      emit(SignUpFailure(result.error.toString()));
    }
  }
}
