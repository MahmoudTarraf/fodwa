import '../../domain/entities/user_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity user;
  ProfileLoaded(this.user);
}

class ProfileUpdating extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {
  final UserEntity user;
  ProfileUpdateSuccess(this.user);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
