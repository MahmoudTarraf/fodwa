import 'package:fodwa/core/handleErrors/result_pattern.dart';
import 'package:fodwa/features/profile/data/models/user_model.dart';
import 'package:fodwa/features/Auth/login/data/models/loginModel.dart';
import 'package:fodwa/features/Auth/login/data/models/social_login_models.dart';

abstract class LoginRDS {
  Future<Result> login(LoginModel model);
  Future<Result> loginWithSocial(SocialLoginModel model);

  Future<Result> sendResetPasswordCode({String? email, String? phone});
  Future<Result> verifyResetCode({
    String? email,
    String? phone,
    required String code,
  });
  Future<Result> resetPassword({
    String? email,
    String? phone,
    required String code,
    required String password,
    required String confirmPassword,
  });

  Future<Result> saveUserData(UserModel user);
}
