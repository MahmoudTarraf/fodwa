import 'package:fodwa/core/apiManager/api_manager.dart';
import 'package:fodwa/core/apiManager/end_points.dart';
import 'package:fodwa/core/cahsing/app_keys.dart';
import 'package:fodwa/core/cahsing/get_storage_helper.dart';
import 'package:fodwa/core/cahsing/secure_storage.dart';
import 'package:fodwa/core/handleErrors/result_pattern.dart';
import 'package:fodwa/core/session/session_manager.dart';
import 'package:fodwa/features/Auth/login/data/models/loginModel.dart';
import 'package:fodwa/features/Auth/login/data/models/social_login_models.dart';
import 'package:fodwa/features/profile/data/models/user_model.dart';
import 'package:fodwa/features/Auth/login/data/data_sources/remote/loginRDS.dart';

class LoginRDSImpl implements LoginRDS {
  @override
  Future<Result> login(LoginModel model) async {
    final response = await ApiService.request(
      endpoint: AppEndPoints.login,
      method: "POST",
      data: model.toJson(),
    );

    if (response is Result && response.isFailure) {
      return response;
    }

    final user = UserModel.fromJson(response['user']);
    final String token = response['access'] ?? "";

    await saveUserData(user);
    await SessionManager.saveSession(token: token, userId: user.id);
    await SessionManager.saveRememberMe(model.rememberMe ?? false);

    return Result.success(user);
  }

  @override
  Future<Result> loginWithSocial(SocialLoginModel model) async {
    final response = await ApiService.request(
      endpoint: model.provider == "google"
          ? AppEndPoints.googleLogin
          : AppEndPoints.appleLogin,
      method: "POST",
      data: model.toJson(),
    );

    if (response is Result && response.isFailure) {
      return response;
    }

    final user = UserModel.fromJson(response['user']);
    final String token = response['access'] ?? "";

    await saveUserData(user);
    await SessionManager.saveSession(token: token, userId: user.id);

    return Result.success(user);
  }

  @override
  Future<Result> sendResetPasswordCode({String? email, String? phone}) async {
    final response = await ApiService.request(
      endpoint: AppEndPoints.forget_pass,
      method: "POST",
      data: {
        if (email != null) "email": email,
        if (phone != null) "phone_number": phone,
      },
    );

    if (response is Result && response.isFailure) {
      return response;
    }

    return Result.success(response['message'] ?? 'Reset code sent');
  }

  @override
  Future<Result> verifyResetCode({
    String? email,
    String? phone,
    required String code,
  }) async {
    final response = await ApiService.request(
      endpoint: AppEndPoints.verify_code,
      method: "POST",
      data: {
        if (email != null) "email": email,
        if (phone != null) "phone_number": phone,
        "code": code,
      },
    );

    if (response is Result && response.isFailure) {
      return response;
    }

    return Result.success(response['message'] ?? 'Code verified');
  }

  @override
  Future<Result> resetPassword({
    String? email,
    String? phone,
    required String code,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await ApiService.request(
      endpoint: AppEndPoints.reset_password,
      method: "POST",
      data: {
        if (email != null) "email": email,
        if (phone != null) "phone_number": phone,
        "code": code,
        "password": password,
        "confirm_password": confirmPassword,
      },
    );

    if (response is Result && response.isFailure) {
      return response;
    }

    return Result.success(response['message'] ?? 'Password reset successfully');
  }

  @override
  Future<Result> saveUserData(UserModel user) async {
    try {
      await SecureStorageHelper.write(AppKeys.userId, user.id.toString());
      await GetStorageHelper.write(AppKeys.name, user.fullName);
      await GetStorageHelper.write(AppKeys.email, user.email);

      return Result.success("data saved");
    } catch (e) {
      return Result.failure("Failed to save data");
    }
  }
}
