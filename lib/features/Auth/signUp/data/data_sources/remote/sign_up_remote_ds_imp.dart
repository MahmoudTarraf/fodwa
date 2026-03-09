import 'package:fodwa/core/apiManager/api_manager.dart';
import 'package:fodwa/core/apiManager/end_points.dart';
import 'package:fodwa/core/handleErrors/result_pattern.dart';
import 'package:fodwa/features/Auth/signUp/data/data_sources/remote/sign_up_rds.dart';
import 'package:fodwa/features/Auth/signUp/data/models/sign_up_model.dart';

class SignUpRemoteDSImp implements SignUpRemoteDS {
  @override
  Future<Result> signUp(SignUpModel request) async {
    // Backend doesn't accept images during sign-up (profile_picture and banner_image are readOnly)
    // Images must be uploaded separately via /files/profile-image/ and /files/banner-image/
    // This is handled by UploadProfileImageUseCase after successful registration
    final data = request.toJson();

    final response = await ApiService.request(
      endpoint: AppEndPoints.register,
      method: "POST",
      data: data,
    );

    if (response is Result && response.isFailure) {
      return response;
    }

    return Result.success(response);
  }

  @override
  Future<Result> verifyEmailOtp({
    required String email,
    required String code,
  }) async {
    final response = await ApiService.request(
      endpoint: AppEndPoints.verify_email_otp,
      method: "POST",
      data: {"email": email, "code": code},
    );

    if (response is Result && response.isFailure) {
      return response;
    }

    return Result.success(response);
  }

  @override
  Result<bool> validateRequest(SignUpModel request) {
    if (request.pass != request.confirmPass) {
      return Result.failure('Passwords do not match');
    }

    if (request.country.trim().isEmpty) {
      return Result.failure('Country is required');
    }

    if (request.city.trim().isEmpty) {
      return Result.failure('City is required');
    }

    if (request.accountType.trim().isEmpty) {
      return Result.failure('account type is required');
    }

    if (request.profileImage != null && request.profileImage!.trim().isEmpty) {
      return Result.failure('Invalid profile image');
    }

    if (request.bannerImage != null && request.bannerImage!.trim().isEmpty) {
      return Result.failure('Invalid banner image');
    }

    if (request.createdAt.isAfter(DateTime.now())) {
      return Result.failure('Invalid creation date');
    }

    if (request.accountType == 'personal') {
      if (request.gender == null || request.gender!.trim().isEmpty) {
        return Result.failure('Gender is required');
      }

      if (request.dateOfBirth == null) {
        return Result.failure('Date of birth is required');
      }

      if (request.generalJob == null || request.generalJob!.trim().isEmpty) {
        return Result.failure('General job is required');
      }

      if (request.relatedJob == null || request.relatedJob!.trim().isEmpty) {
        return Result.failure('Related job is required');
      }

      if (request.skills != null && request.skills!.isEmpty) {
        return Result.failure('Please add at least one skill');
      }
    }

    if (request.accountType == 'company') {
      if (request.businessSector == null ||
          request.businessSector!.trim().isEmpty) {
        return Result.failure('Business sector is required');
      }

      if (request.taxNumber == null || request.taxNumber!.trim().isEmpty) {
        return Result.failure('Tax number is required');
      }

      if (request.servicesOffered == null || request.servicesOffered!.isEmpty) {
        return Result.failure('Please add at least one service');
      }
    }

    return Result.success(true);
  }
}
