import 'package:fodwa/core/handleErrors/result_pattern.dart';
import 'package:fodwa/features/Auth/login/domain/repositories/loginDomainRepo.dart';
import 'package:fodwa/features/Auth/login/data/data_sources/remote/loginRDS.dart';
import 'package:fodwa/features/Auth/login/data/models/loginModel.dart';
import 'package:fodwa/features/Auth/login/data/models/social_login_models.dart';

class LoginDataRepoImpl implements LoginDomainRepo {
  final LoginRDS loginRDS;

  LoginDataRepoImpl(this.loginRDS);

  @override
  Future<Result> login(LoginModel model) {
    return loginRDS.login(model);
  }

  @override
  Future<Result> loginWithSocial(SocialLoginModel model) {
    return loginRDS.loginWithSocial(model);
  }

  @override
  Future<Result> sendResetPasswordCode({String? email, String? phone}) {
    return loginRDS.sendResetPasswordCode(email: email, phone: phone);
  }

  @override
  Future<Result> verifyResetCode({
    String? email,
    String? phone,
    required String code,
  }) {
    return loginRDS.verifyResetCode(email: email, phone: phone, code: code);
  }

  @override
  Future<Result> resetPassword({
    String? email,
    String? phone,
    required String code,
    required String password,
    required String confirmPassword,
  }) {
    return loginRDS.resetPassword(
      email: email,
      phone: phone,
      code: code,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
