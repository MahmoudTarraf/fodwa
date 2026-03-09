import 'package:equatable/equatable.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:fodwa/features/Auth/login/data/models/loginModel.dart';
import 'package:fodwa/features/Auth/login/data/models/social_login_models.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final LoginModel model;

  LoginButtonPressed({required this.model});

  @override
  List<Object?> get props => [model];
}

class SetRemember extends LoginEvent {
  final bool isRemember;

  SetRemember({required this.isRemember});

  @override
  List<Object?> get props => [isRemember];
}

class ForgetPasswordPressed extends LoginEvent {
  final String? email;
  final String? phone;

  ForgetPasswordPressed({this.email, this.phone});

  @override
  List<Object?> get props => [email, phone];
}

class CodeVerify extends LoginEvent {
  final String? email;
  final String? phone;
  final String code;

  CodeVerify({this.email, this.phone, required this.code});

  @override
  List<Object?> get props => [email, phone, code];
}

class CreateNewPassEvent extends LoginEvent {
  final String? email;
  final String? phone;
  final String code;
  final String pass;
  final String confirmPass;

  CreateNewPassEvent({
    this.email,
    this.phone,
    required this.code,
    required this.pass,
    required this.confirmPass,
  });

  @override
  List<Object?> get props => [email, phone, code, pass, confirmPass];
}

class ChangeLoginTab extends LoginEvent {
  final int index;

  ChangeLoginTab(this.index);

  @override
  List<Object?> get props => [index];
}

class UpdatePhoneNumber extends LoginEvent {
  final PhoneNumber phoneNumber;

  UpdatePhoneNumber(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber.isoCode, phoneNumber.phoneNumber];
}

class ResetLoginState extends LoginEvent {}

class SocialLoginButtonPressed extends LoginEvent {
  final SocialLoginModel model;

  SocialLoginButtonPressed({required this.model});

  @override
  List<Object?> get props => [model];
}

class VerifyRegistrationOtp extends LoginEvent {
  final String email;
  final String code;
  final String? profileImagePath;

  VerifyRegistrationOtp({
    required this.email,
    required this.code,
    this.profileImagePath,
  });

  @override
  List<Object?> get props => [email, code, profileImagePath];
}
