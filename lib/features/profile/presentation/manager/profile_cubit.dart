import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:fodwa/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:fodwa/features/profile/domain/use_cases/partial_update_profile_use_case.dart';
import 'package:fodwa/features/profile/domain/use_cases/upload_profile_image_use_case.dart';
import 'package:fodwa/features/profile/domain/entities/user_entity.dart';
import 'package:fodwa/features/profile/presentation/manager/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final PartialUpdateProfileUseCase partialUpdateProfileUseCase;
  final UploadProfileImageUseCase uploadProfileImageUseCase;

  ProfileCubit(
    this.getProfileUseCase,
    this.updateProfileUseCase,
    this.partialUpdateProfileUseCase,
    this.uploadProfileImageUseCase,
  ) : super(ProfileInitial());

  Future<void> loadProfile() async {
    return getProfile(); // alias to getProfile or we can just rename. We kept getProfile as well.
  }

  Future<void> getProfile() async {
    emit(ProfileLoading());
    final result = await getProfileUseCase();

    if (result.isSuccess && result.data != null) {
      emit(ProfileLoaded(result.data!));
    } else {
      emit(ProfileError(result.error ?? "Profile data is missing"));
    }
  }

  Future<void> updateProfile(UserEntity user) async {
    emit(ProfileUpdating());
    final result = await updateProfileUseCase(user);

    if (result.isSuccess && result.data != null) {
      emit(ProfileUpdateSuccess(result.data!));
    } else {
      emit(ProfileError(result.error ?? "Failed to update profile"));
    }
  }

  Future<void> partialUpdateProfile(Map<String, dynamic> data) async {
    emit(ProfileUpdating());
    final result = await partialUpdateProfileUseCase(data);

    if (result.isSuccess && result.data != null) {
      emit(ProfileUpdateSuccess(result.data!));
    } else {
      emit(ProfileError(result.error ?? "Failed to partially update profile"));
    }
  }

  Future<void> uploadProfileImage(String imagePath) async {
    emit(ProfileUpdating());
    final result = await uploadProfileImageUseCase(imagePath);

    if (result.isSuccess && result.data != null) {
      emit(ProfileUpdateSuccess(result.data!));
    } else {
      emit(ProfileError(result.error ?? "Failed to upload profile image"));
    }
  }
}
