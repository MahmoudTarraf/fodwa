// ==========================================
import 'package:equatable/equatable.dart';
import 'package:fodwa/features/Auth/signUp/data/models/country_model.dart';
import 'package:fodwa/features/Auth/signUp/data/models/sign_up_model.dart';

import '../../data/models/account_type.dart';
import '../../data/models/busnuess.dart';
import '../../data/models/gender.dart';
import '../../data/models/general_jop.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpButtonPressed extends SignUpEvent {
  final SignUpModel user;
  SignUpButtonPressed(this.user);

  @override
  List<Object?> get props => [user];
}

class SelectCountryEvent extends SignUpEvent {
  final CountryModel countryModel;
  SelectCountryEvent(this.countryModel);
}

class SelectCityEvent extends SignUpEvent {
  final CityModel cityModel;
  SelectCityEvent(this.cityModel);

  @override
  List<Object?> get props => [cityModel];
}

class SelectAccountTypeEvent extends SignUpEvent {
  final AccountType accountType;
  SelectAccountTypeEvent(this.accountType);

  @override
  List<Object?> get props => [accountType];
}

class SelectGenderEvent extends SignUpEvent {
  final Gender gender;
  SelectGenderEvent(this.gender);
}

class SelectGeneralJobEvent extends SignUpEvent {
  final GeneralJobModel job;
  SelectGeneralJobEvent(this.job);

  @override
  List<Object?> get props => [job];
}

class SelectRelatedJobEvent extends SignUpEvent {
  final RelatedJobModel job;
  SelectRelatedJobEvent(this.job);

  @override
  List<Object?> get props => [job];
}

class AddSkillEvent extends SignUpEvent {
  final String skill;
  AddSkillEvent(this.skill);

  @override
  List<Object?> get props => [skill];
}

class RemoveSkillEvent extends SignUpEvent {
  final String skill;
  RemoveSkillEvent(this.skill);

  @override
  List<Object?> get props => [skill];
}

// ✅ NEW: Date of Birth Event
class SelectDateOfBirthEvent extends SignUpEvent {
  final DateTime dateOfBirth;
  SelectDateOfBirthEvent(this.dateOfBirth);

  @override
  List<Object?> get props => [dateOfBirth];
}

class SelectBusinessSectorEvent extends SignUpEvent {
  final BusinessSectorModel sector;

  SelectBusinessSectorEvent(this.sector);

  @override
  List<Object?> get props => [sector];
}

class AddServiceEvent extends SignUpEvent {
  final String service;
  AddServiceEvent(this.service);
}

class RemoveServiceEvent extends SignUpEvent {
  final String service;
  RemoveServiceEvent(this.service);
}

class SelectProfileImageEvent extends SignUpEvent {
  final String? imagePath;
  SelectProfileImageEvent(this.imagePath);

  @override
  List<Object?> get props => [imagePath];
}

class SelectBannerImageEvent extends SignUpEvent {
  final String? bannerPath;
  SelectBannerImageEvent(this.bannerPath);

  @override
  List<Object?> get props => [bannerPath];
}

class UpdatePhoneNumberEvent extends SignUpEvent {
  final String phoneNumber;
  final String isoCode;

  UpdatePhoneNumberEvent({required this.phoneNumber, required this.isoCode});

  @override
  List<Object?> get props => [phoneNumber, isoCode];
}

class TogglePolicyEvent extends SignUpEvent {
  final bool isAccepted;
  TogglePolicyEvent(this.isAccepted);

  @override
  List<Object?> get props => [isAccepted];
}
