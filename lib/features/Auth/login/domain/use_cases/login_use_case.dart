import 'package:fodwa/core/handleErrors/result_pattern.dart';
import 'package:fodwa/features/Auth/login/data/models/loginModel.dart';
import 'package:fodwa/features/Auth/login/data/models/social_login_models.dart';
import 'package:fodwa/features/Auth/login/domain/repositories/loginDomainRepo.dart';

class LoginUseCase {
  LoginDomainRepo loginDomainRepo;

  LoginUseCase(this.loginDomainRepo);

  Future<Result> login(LoginModel model) async {
    final result = await loginDomainRepo.login(model);
    if (result.isSuccess) {
      return Result.success(result.data);
    } else {
      return Result.failure(result.error);
    }
  }

  Future<Result> login_with_social(SocialLoginModel model) async {
    final result = await loginDomainRepo.loginWithSocial(model);
    if (result.isSuccess) {
      return Result.success(result.data);
    } else {
      return Result.failure(result.error);
    }
  }
}
