import 'package:dio/dio.dart';
import 'package:fodwa/core/apiManager/api_manager.dart';
import 'package:fodwa/core/apiManager/end_points.dart';
import 'package:fodwa/core/handleErrors/result_pattern.dart';
import 'package:fodwa/features/profile/data/models/user_model.dart';

abstract class ProfileRemoteDS {
  Future<Result<UserModel>> getProfile();
  Future<Result<UserModel>> updateProfile(UserModel user);
  Future<Result<UserModel>> partialUpdateProfile(Map<String, dynamic> data);
  Future<Result<UserModel>> uploadProfileImage(String imagePath);
}

class ProfileRemoteDSImpl implements ProfileRemoteDS {
  @override
  Future<Result<UserModel>> getProfile() async {
    try {
      final response = await ApiService.request(
        endpoint: AppEndPoints.profile,
        method: "GET",
      );

      if (response is Result && response.isFailure) {
        return Result.failure(response.error);
      }

      final result = UserModel.fromJson(response);
      return Result.success(result);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<UserModel>> updateProfile(UserModel user) async {
    try {
      print('*** Updating Profile (Full) ***');
      print('Endpoint: ${AppEndPoints.updateProfile}');
      print('Payload: ${user.toJson()}');
      
      final response = await ApiService.request(
        endpoint: AppEndPoints.updateProfile,
        method: "PATCH",
        data: user.toJson(),
      );

      if (response is Result && response.isFailure) {
        return Result.failure(response.error);
      }

      print('*** Update Response ***');
      print(response);
      final result = UserModel.fromJson(response);
      return Result.success(result);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<UserModel>> partialUpdateProfile(Map<String, dynamic> data) async {
    try {
      print('*** Updating Profile (Partial) ***');
      print('Endpoint: ${AppEndPoints.updateProfile}');
      print('Payload: $data');
      
      final response = await ApiService.request(
        endpoint: AppEndPoints.updateProfile,
        method: "PATCH",
        data: data,
      );

      if (response is Result && response.isFailure) {
        return Result.failure(response.error);
      }

      print('*** Partial Update Response ***');
      print(response);
      final result = UserModel.fromJson(response);
      return Result.success(result);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<UserModel>> uploadProfileImage(String imagePath) async {
    try {
      // Step 1: Delete existing image (optional, since it might not exist)
      try {
        print('*** Deleting existing Profile Image (if any) ***');
        await ApiService.request(
          endpoint: AppEndPoints.profileImage,
          method: "DELETE",
        );
      } catch (e) {
        print('Delete profile image failed (expected if none exists): $e');
        // We continue anyway
      }

      // Step 2: Upload new image
      final formData = FormData.fromMap({
        'file': await ApiService.createMultipartFile(filePath: imagePath),
      });

      print('*** Uploading Profile Image ***');
      print('Endpoint: ${AppEndPoints.profileImage}');

      final response = await ApiService.requestWithFormData(
        endpoint: AppEndPoints.profileImage,
        method: "POST",
        data: formData,
      );

      print('*** Upload Response ***');
      print(response);

      if (response is Result && response.isFailure) {
        print('Upload failed: ${response.error}');
        return Result.failure(response.error);
      }

      try {
        final result = UserModel.fromJson(response);
        print('*** Parsed User Model ***');
        print('New Profile Image: ${result.profileImage}');
        return Result.success(result);
      } catch (e) {
        print('Error parsing response: $e');
        return Result.failure('Parsing error: $e');
      }
    } catch (e) {
      print('Exception during upload: $e');
      return Result.failure(e.toString());
    }
  }
}
