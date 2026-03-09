// features/sign_up/domain/repositories/sign_up_domain_repo.dart

import '../../../../../core/handleErrors/result_pattern.dart';
import '../../data/models/sign_up_model.dart';

abstract class SignUpDomainRepo {
  Result<bool> validateRatingRequest(SignUpModel request);

  Future<Result> signUp(SignUpModel request);

  Future<Result> verifyEmailOtp({required String email, required String code});
}
