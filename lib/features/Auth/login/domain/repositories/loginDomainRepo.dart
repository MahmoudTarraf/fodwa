import 'package:fodwa/core/handleErrors/result_pattern.dart';
import 'package:fodwa/features/Auth/login/data/models/loginModel.dart';
import 'package:fodwa/features/Auth/login/data/models/social_login_models.dart';

abstract class LoginDomainRepo {
  Future<Result> sendResetPasswordCode({String? email, String? phone});
  Future<Result> verifyResetCode({
    String? email,
    String? phone,
    required String code,
  });
  Future<Result> login(LoginModel model);
  Future<Result> loginWithSocial(SocialLoginModel model);
  Future<Result> resetPassword({
    String? email,
    String? phone,
    required String code,
    required String password,
    required String confirmPassword,
  });
}
