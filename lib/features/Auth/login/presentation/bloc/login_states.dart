import 'package:equatable/equatable.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

abstract class LoginState extends Equatable {
  final bool isRemember;
  final int selectedTab; // 0 = email, 1 = phone
  final String? email;
  final PhoneNumber phoneNumber;

  LoginState({
    this.isRemember = false,
    this.selectedTab = 0,
    this.email,
    PhoneNumber? phoneNumber,
  }) : phoneNumber = phoneNumber ?? PhoneNumber(isoCode: 'SA');

  LoginState copyWith({
    bool? isRemember,
    int? selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  });

  @override
  List<Object?> get props => [
    isRemember,
    selectedTab,
    email,
    phoneNumber.isoCode,
    phoneNumber.phoneNumber,
  ];
}

class LoginInitial extends LoginState {
  LoginInitial({
    bool isRemember = false,
    int selectedTab = 0,
    String? email,
    PhoneNumber? phoneNumber,
  }) : super(
         isRemember: isRemember,
         selectedTab: selectedTab,
         email: email,
         phoneNumber: phoneNumber,
       );

  @override
  LoginInitial copyWith({
    bool? isRemember,
    int? selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) {
    return LoginInitial(
      isRemember: isRemember ?? this.isRemember,
      selectedTab: selectedTab ?? this.selectedTab,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

class PhoneNumberUpdated extends LoginState {
  PhoneNumberUpdated({
    required bool isRemember,
    required int selectedTab,
    String? email,
    required PhoneNumber phoneNumber,
  }) : super(
         isRemember: isRemember,
         selectedTab: selectedTab,
         email: email,
         phoneNumber: phoneNumber,
       );

  @override
  PhoneNumberUpdated copyWith({
    bool? isRemember,
    int? selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) {
    return PhoneNumberUpdated(
      isRemember: isRemember ?? this.isRemember,
      selectedTab: selectedTab ?? this.selectedTab,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

class LoginLoading extends LoginState {
  LoginLoading({
    required bool isRemember,
    required int selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) : super(
         isRemember: isRemember,
         selectedTab: selectedTab,
         email: email,
         phoneNumber: phoneNumber,
       );

  @override
  LoginLoading copyWith({
    bool? isRemember,
    int? selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) {
    return LoginLoading(
      isRemember: isRemember ?? this.isRemember,
      selectedTab: selectedTab ?? this.selectedTab,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

class LoginSuccess extends LoginState {
  LoginSuccess({
    required bool isRemember,
    required int selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) : super(
         isRemember: isRemember,
         selectedTab: selectedTab,
         email: email,
         phoneNumber: phoneNumber,
       );

  @override
  LoginSuccess copyWith({
    bool? isRemember,
    int? selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) {
    return LoginSuccess(
      isRemember: isRemember ?? this.isRemember,
      selectedTab: selectedTab ?? this.selectedTab,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(
    this.error, {
    required bool isRemember,
    required int selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) : super(
         isRemember: isRemember,
         selectedTab: selectedTab,
         email: email,
         phoneNumber: phoneNumber,
       );

  @override
  LoginFailure copyWith({
    bool? isRemember,
    int? selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) {
    return LoginFailure(
      error,
      isRemember: isRemember ?? this.isRemember,
      selectedTab: selectedTab ?? this.selectedTab,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [error, ...super.props];
}

class ForgetEmailPassLoading extends LoginState {
  ForgetEmailPassLoading({
    required bool isRemember,
    required int selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) : super(
         isRemember: isRemember,
         selectedTab: selectedTab,
         email: email,
         phoneNumber: phoneNumber,
       );

  @override
  ForgetEmailPassLoading copyWith({
    bool? isRemember,
    int? selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) {
    return ForgetEmailPassLoading(
      isRemember: isRemember ?? this.isRemember,
      selectedTab: selectedTab ?? this.selectedTab,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

class SendEmailSuccess extends LoginState {
  SendEmailSuccess({
    required bool isRemember,
    required int selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) : super(
         isRemember: isRemember,
         selectedTab: selectedTab,
         email: email,
         phoneNumber: phoneNumber,
       );

  @override
  SendEmailSuccess copyWith({
    bool? isRemember,
    int? selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) {
    return SendEmailSuccess(
      isRemember: isRemember ?? this.isRemember,
      selectedTab: selectedTab ?? this.selectedTab,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

class VerifiedSuccess extends LoginState {
  VerifiedSuccess({
    required bool isRemember,
    required int selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) : super(
         isRemember: isRemember,
         selectedTab: selectedTab,
         email: email,
         phoneNumber: phoneNumber,
       );

  @override
  VerifiedSuccess copyWith({
    bool? isRemember,
    int? selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) {
    return VerifiedSuccess(
      isRemember: isRemember ?? this.isRemember,
      selectedTab: selectedTab ?? this.selectedTab,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

class SendEmailFailure extends LoginState {
  final String error;

  SendEmailFailure(
    this.error, {
    required bool isRemember,
    required int selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) : super(
         isRemember: isRemember,
         selectedTab: selectedTab,
         email: email,
         phoneNumber: phoneNumber,
       );

  @override
  SendEmailFailure copyWith({
    bool? isRemember,
    int? selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) {
    return SendEmailFailure(
      error,
      isRemember: isRemember ?? this.isRemember,
      selectedTab: selectedTab ?? this.selectedTab,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [error, ...super.props];
}

class VerifyFailure extends LoginState {
  final String error;

  VerifyFailure(
    this.error, {
    required bool isRemember,
    required int selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) : super(
         isRemember: isRemember,
         selectedTab: selectedTab,
         email: email,
         phoneNumber: phoneNumber,
       );

  @override
  VerifyFailure copyWith({
    bool? isRemember,
    int? selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) {
    return VerifyFailure(
      error,
      isRemember: isRemember ?? this.isRemember,
      selectedTab: selectedTab ?? this.selectedTab,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [error, ...super.props];
}

class PasswordCreatedSuccess extends LoginState {
  PasswordCreatedSuccess({
    required bool isRemember,
    required int selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) : super(
         isRemember: isRemember,
         selectedTab: selectedTab,
         email: email,
         phoneNumber: phoneNumber,
       );

  @override
  PasswordCreatedSuccess copyWith({
    bool? isRemember,
    int? selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) {
    return PasswordCreatedSuccess(
      isRemember: isRemember ?? this.isRemember,
      selectedTab: selectedTab ?? this.selectedTab,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

class PassCreatedFailure extends LoginState {
  final String error;

  PassCreatedFailure(
    this.error, {
    required bool isRemember,
    required int selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) : super(
         isRemember: isRemember,
         selectedTab: selectedTab,
         email: email,
         phoneNumber: phoneNumber,
       );

  @override
  PassCreatedFailure copyWith({
    bool? isRemember,
    int? selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) {
    return PassCreatedFailure(
      error,
      isRemember: isRemember ?? this.isRemember,
      selectedTab: selectedTab ?? this.selectedTab,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [error, ...super.props];
}

class RegistrationVerifiedSuccess extends LoginState {
  RegistrationVerifiedSuccess({
    required bool isRemember,
    required int selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) : super(
         isRemember: isRemember,
         selectedTab: selectedTab,
         email: email,
         phoneNumber: phoneNumber,
       );

  @override
  RegistrationVerifiedSuccess copyWith({
    bool? isRemember,
    int? selectedTab,
    String? email,
    PhoneNumber? phoneNumber,
  }) {
    return RegistrationVerifiedSuccess(
      isRemember: isRemember ?? this.isRemember,
      selectedTab: selectedTab ?? this.selectedTab,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
