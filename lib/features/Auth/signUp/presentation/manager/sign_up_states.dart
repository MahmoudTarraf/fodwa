import 'package:equatable/equatable.dart';

import '../../data/models/account_type.dart';
import '../../data/models/busnuess.dart';
import '../../data/models/country_model.dart';
import '../../data/models/gender.dart';
import '../../data/models/general_jop.dart';

/// =======================================================
/// BASE STATE
/// =======================================================
abstract class SignUpState extends Equatable {
  final CountryModel? selectedCountry;
  final CityModel? selectedCity;
  final AccountType? accountType;
  final Gender? gender;

  /// ✅ Business
  final BusinessSectorModel? selectedBusinessSector;

  /// ✅ Jobs
  final GeneralJobModel? selectedGeneralJob;
  final RelatedJobModel? selectedRelatedJob;

  /// ✅ Skills & Services
  final List<String> selectedSkills;
  final List<String> selectedServices;

  /// ✅ DOB
  final DateTime? dateOfBirth;

  /// ✅ Images
  final String? profileImagePath;
  final String? bannerImagePath;

  /// ✅ Phone
  final String? phoneNumberText;
  final String? isoCode;

  /// ✅ Policy
  final bool isPolicyAccepted;

  const SignUpState({
    this.selectedCountry,
    this.selectedCity,
    this.accountType = AccountType.personal,
    this.gender,
    this.selectedBusinessSector,
    this.selectedGeneralJob,
    this.selectedRelatedJob,
    this.selectedSkills = const [],
    this.selectedServices = const [],
    this.dateOfBirth,
    this.profileImagePath,
    this.bannerImagePath,
    this.phoneNumberText,
    this.isoCode = 'SA',
    this.isPolicyAccepted = false,
  });

  SignUpState copyWith({
    CountryModel? selectedCountry,
    CityModel? selectedCity,
    AccountType? accountType,
    Gender? gender,
    BusinessSectorModel? selectedBusinessSector,
    GeneralJobModel? selectedGeneralJob,
    RelatedJobModel? selectedRelatedJob,
    List<String>? selectedSkills,
    List<String>? selectedServices,
    DateTime? dateOfBirth,
    String? profileImagePath,
    String? bannerImagePath,
    String? phoneNumberText,
    String? isoCode,
    bool? isPolicyAccepted,
  });

  @override
  List<Object?> get props => [
    selectedCountry,
    selectedCity,
    accountType,
    gender,
    selectedBusinessSector,
    selectedGeneralJob,
    selectedRelatedJob,
    selectedSkills,
    selectedServices,
    dateOfBirth,
    profileImagePath,
    bannerImagePath,
    phoneNumberText,
    isoCode,
    isPolicyAccepted,
  ];
}

/// =======================================================
/// INITIAL
/// =======================================================
class SignUpInitial extends SignUpState {
  const SignUpInitial({
    super.selectedCountry,
    super.selectedCity,
    super.accountType,
    super.gender,
    super.selectedBusinessSector,
    super.selectedGeneralJob,
    super.selectedRelatedJob,
    super.selectedSkills,
    super.selectedServices,
    super.dateOfBirth,
    super.profileImagePath,
    super.bannerImagePath,
    super.phoneNumberText,
    super.isoCode,
    super.isPolicyAccepted,
  });

  @override
  SignUpInitial copyWith({
    CountryModel? selectedCountry,
    CityModel? selectedCity,
    AccountType? accountType,
    Gender? gender,
    BusinessSectorModel? selectedBusinessSector,
    GeneralJobModel? selectedGeneralJob,
    RelatedJobModel? selectedRelatedJob,
    List<String>? selectedSkills,
    List<String>? selectedServices,
    DateTime? dateOfBirth,
    String? profileImagePath,
    String? bannerImagePath,
    String? phoneNumberText,
    String? isoCode,
    bool? isPolicyAccepted,
  }) {
    return SignUpInitial(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedCity: selectedCity ?? this.selectedCity,
      accountType: accountType ?? this.accountType,
      gender: gender ?? this.gender,
      selectedBusinessSector:
          selectedBusinessSector ?? this.selectedBusinessSector,
      selectedGeneralJob: selectedGeneralJob ?? this.selectedGeneralJob,
      selectedRelatedJob: selectedRelatedJob ?? this.selectedRelatedJob,
      selectedSkills: selectedSkills ?? this.selectedSkills,
      selectedServices: selectedServices ?? this.selectedServices,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      bannerImagePath: bannerImagePath ?? this.bannerImagePath,
      phoneNumberText: phoneNumberText ?? this.phoneNumberText,
      isoCode: isoCode ?? this.isoCode,
      isPolicyAccepted: isPolicyAccepted ?? this.isPolicyAccepted,
    );
  }
}

/// =======================================================
/// LOADING
/// =======================================================
class SignUpLoading extends SignUpState {
  const SignUpLoading({
    super.selectedCountry,
    super.selectedCity,
    super.accountType,
    super.gender,
    super.selectedBusinessSector,
    super.selectedGeneralJob,
    super.selectedRelatedJob,
    super.selectedSkills,
    super.selectedServices,
    super.dateOfBirth,
    super.profileImagePath,
    super.bannerImagePath,
    super.phoneNumberText,
    super.isoCode,
    super.isPolicyAccepted,
  });

  @override
  SignUpLoading copyWith({
    CountryModel? selectedCountry,
    CityModel? selectedCity,
    AccountType? accountType,
    Gender? gender,
    BusinessSectorModel? selectedBusinessSector,
    GeneralJobModel? selectedGeneralJob,
    RelatedJobModel? selectedRelatedJob,
    List<String>? selectedSkills,
    List<String>? selectedServices,
    DateTime? dateOfBirth,
    String? profileImagePath,
    String? bannerImagePath,
    String? phoneNumberText,
    String? isoCode,
    bool? isPolicyAccepted,
  }) {
    return SignUpLoading(
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedCity: selectedCity ?? this.selectedCity,
      accountType: accountType ?? this.accountType,
      gender: gender ?? this.gender,
      selectedBusinessSector:
          selectedBusinessSector ?? this.selectedBusinessSector,
      selectedGeneralJob: selectedGeneralJob ?? this.selectedGeneralJob,
      selectedRelatedJob: selectedRelatedJob ?? this.selectedRelatedJob,
      selectedSkills: selectedSkills ?? this.selectedSkills,
      selectedServices: selectedServices ?? this.selectedServices,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      bannerImagePath: bannerImagePath ?? this.bannerImagePath,
      phoneNumberText: phoneNumberText ?? this.phoneNumberText,
      isoCode: isoCode ?? this.isoCode,
      isPolicyAccepted: isPolicyAccepted ?? this.isPolicyAccepted,
    );
  }
}

/// =======================================================
/// SUCCESS
/// =======================================================
class SignUpSuccess extends SignUpState {
  final String message;
  final String? email;
  final String? profileImagePath;

  const SignUpSuccess(
    this.message, {
    this.email,
    this.profileImagePath,
    super.selectedCountry,
    super.selectedCity,
    super.accountType,
    super.gender,
    super.selectedBusinessSector,
    super.selectedGeneralJob,
    super.selectedRelatedJob,
    super.selectedSkills,
    super.selectedServices,
    super.dateOfBirth,
    super.bannerImagePath,
    super.phoneNumberText,
    super.isoCode,
    super.isPolicyAccepted,
  });

  @override
  SignUpSuccess copyWith({
    String? message,
    String? email,
    String? profileImagePath,
    CountryModel? selectedCountry,
    CityModel? selectedCity,
    AccountType? accountType,
    Gender? gender,
    BusinessSectorModel? selectedBusinessSector,
    GeneralJobModel? selectedGeneralJob,
    RelatedJobModel? selectedRelatedJob,
    List<String>? selectedSkills,
    List<String>? selectedServices,
    DateTime? dateOfBirth,
    String? bannerImagePath,
    String? phoneNumberText,
    String? isoCode,
    bool? isPolicyAccepted,
  }) {
    return SignUpSuccess(
      message ?? this.message,
      email: email ?? this.email,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedCity: selectedCity ?? this.selectedCity,
      accountType: accountType ?? this.accountType,
      gender: gender ?? this.gender,
      selectedBusinessSector:
          selectedBusinessSector ?? this.selectedBusinessSector,
      selectedGeneralJob: selectedGeneralJob ?? this.selectedGeneralJob,
      selectedRelatedJob: selectedRelatedJob ?? this.selectedRelatedJob,
      selectedSkills: selectedSkills ?? this.selectedSkills,
      selectedServices: selectedServices ?? this.selectedServices,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      bannerImagePath: bannerImagePath ?? this.bannerImagePath,
      phoneNumberText: phoneNumberText ?? this.phoneNumberText,
      isoCode: isoCode ?? this.isoCode,
      isPolicyAccepted: isPolicyAccepted ?? this.isPolicyAccepted,
    );
  }

  @override
  List<Object?> get props =>
      super.props..addAll([message, email, profileImagePath]);
}

/// =======================================================
/// FAILURE
/// =======================================================
class SignUpFailure extends SignUpState {
  final String error;

  const SignUpFailure(
    this.error, {
    super.selectedCountry,
    super.selectedCity,
    super.accountType,
    super.gender,
    super.selectedBusinessSector,
    super.selectedGeneralJob,
    super.selectedRelatedJob,
    super.selectedSkills,
    super.selectedServices,
    super.dateOfBirth,
    super.profileImagePath,
    super.bannerImagePath,
    super.phoneNumberText,
    super.isoCode,
    super.isPolicyAccepted,
  });

  @override
  SignUpFailure copyWith({
    String? error,
    CountryModel? selectedCountry,
    CityModel? selectedCity,
    AccountType? accountType,
    Gender? gender,
    BusinessSectorModel? selectedBusinessSector,
    GeneralJobModel? selectedGeneralJob,
    RelatedJobModel? selectedRelatedJob,
    List<String>? selectedSkills,
    List<String>? selectedServices,
    DateTime? dateOfBirth,
    String? profileImagePath,
    String? bannerImagePath,
    String? phoneNumberText,
    String? isoCode,
    bool? isPolicyAccepted,
  }) {
    return SignUpFailure(
      error ?? this.error,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedCity: selectedCity ?? this.selectedCity,
      accountType: accountType ?? this.accountType,
      gender: gender ?? this.gender,
      selectedBusinessSector:
          selectedBusinessSector ?? this.selectedBusinessSector,
      selectedGeneralJob: selectedGeneralJob ?? this.selectedGeneralJob,
      selectedRelatedJob: selectedRelatedJob ?? this.selectedRelatedJob,
      selectedSkills: selectedSkills ?? this.selectedSkills,
      selectedServices: selectedServices ?? this.selectedServices,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      bannerImagePath: bannerImagePath ?? this.bannerImagePath,
      phoneNumberText: phoneNumberText ?? this.phoneNumberText,
      isoCode: isoCode ?? this.isoCode,
      isPolicyAccepted: isPolicyAccepted ?? this.isPolicyAccepted,
    );
  }

  @override
  List<Object?> get props => super.props..add(error);
}

/// =======================================================
/// VALIDATION ERROR
/// =======================================================
class SignUpValidationError extends SignUpState {
  final String error;

  const SignUpValidationError(
    this.error, {
    super.selectedCountry,
    super.selectedCity,
    super.accountType,
    super.gender,
    super.selectedBusinessSector,
    super.selectedGeneralJob,
    super.selectedRelatedJob,
    super.selectedSkills,
    super.selectedServices,
    super.dateOfBirth,
    super.profileImagePath,
    super.bannerImagePath,
    super.phoneNumberText,
    super.isoCode,
    super.isPolicyAccepted,
  });

  @override
  SignUpValidationError copyWith({
    CountryModel? selectedCountry,
    CityModel? selectedCity,
    AccountType? accountType,
    List<String>? selectedServices,
    Gender? gender,
    BusinessSectorModel? selectedBusinessSector,
    GeneralJobModel? selectedGeneralJob,
    RelatedJobModel? selectedRelatedJob,
    List<String>? selectedSkills,
    DateTime? dateOfBirth,
    String? profileImagePath,
    String? bannerImagePath,
    String? phoneNumberText,
    String? isoCode,
    bool? isPolicyAccepted,
  }) {
    return SignUpValidationError(
      error,
      selectedServices: selectedServices ?? this.selectedServices,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedCity: selectedCity ?? this.selectedCity,
      accountType: accountType ?? this.accountType,
      gender: gender ?? this.gender,
      selectedBusinessSector:
          selectedBusinessSector ?? this.selectedBusinessSector,
      selectedGeneralJob: selectedGeneralJob ?? this.selectedGeneralJob,
      selectedRelatedJob: selectedRelatedJob ?? this.selectedRelatedJob,
      selectedSkills: selectedSkills ?? this.selectedSkills,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      bannerImagePath: bannerImagePath ?? this.bannerImagePath,
      phoneNumberText: phoneNumberText ?? this.phoneNumberText,
      isoCode: isoCode ?? this.isoCode,
      isPolicyAccepted: isPolicyAccepted ?? this.isPolicyAccepted,
    );
  }

  @override
  List<Object?> get props => super.props..add(error);
}
