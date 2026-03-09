import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:fodwa/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:fodwa/features/profile/domain/use_cases/upload_profile_image_use_case.dart';
import 'package:fodwa/features/profile/domain/entities/user_entity.dart';
import 'package:fodwa/features/profile/presentation/manager/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final UploadProfileImageUseCase uploadProfileImageUseCase;

  ProfileCubit(
    this.getProfileUseCase,
    this.updateProfileUseCase,
    this.uploadProfileImageUseCase,
  ) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    final result = await getProfileUseCase();

    if (result.isSuccess && result.data != null) {
      emit(ProfileSuccess(result.data!));
    } else {
      emit(ProfileError(result.error ?? "Profile data is missing"));
    }
  }

  Future<void> updateProfile(UserEntity user) async {
    emit(ProfileLoading());
    final result = await updateProfileUseCase(user);

    if (result.isSuccess && result.data != null) {
      emit(ProfileSuccess(result.data!));
    } else {
      emit(ProfileError(result.error ?? "Failed to update profile"));
    }
  }

  Future<void> uploadProfileImage(String imagePath) async {
    emit(ProfileLoading());
    final result = await uploadProfileImageUseCase(imagePath);

    if (result.isSuccess && result.data != null) {
      emit(ProfileSuccess(result.data!));
    } else {
      emit(ProfileError(result.error ?? "Failed to upload profile image"));
    }
  }
}
