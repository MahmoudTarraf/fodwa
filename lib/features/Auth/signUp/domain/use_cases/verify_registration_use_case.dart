import 'package:fodwa/core/handleErrors/result_pattern.dart';
import 'package:fodwa/features/Auth/signUp/domain/repositories/sign_up_repo_domain.dart';

class VerifyRegistrationUseCase {
  final SignUpDomainRepo repo;

  VerifyRegistrationUseCase(this.repo);

  Future<Result> call({required String email, required String code}) {
    return repo.verifyEmailOtp(email: email, code: code);
  }
}
