import 'package:fodwa/core/handleErrors/result_pattern.dart';
import 'package:fodwa/features/Auth/login/domain/repositories/loginDomainRepo.dart';

class ForgetPasswordUseCase {
  final LoginDomainRepo repo;

  ForgetPasswordUseCase(this.repo);

  Future<Result> sendResetCode({String? email, String? phone}) {
    return repo.sendResetPasswordCode(email: email, phone: phone);
  }

  Future<Result> verifyCode({
    String? email,
    String? phone,
    required String code,
  }) {
    return repo.verifyResetCode(email: email, phone: phone, code: code);
  }

  Future<Result> resetPassword({
    String? email,
    String? phone,
    required String code,
    required String password,
    required String confirmPassword,
  }) {
    return repo.resetPassword(
      email: email,
      phone: phone,
      code: code,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
