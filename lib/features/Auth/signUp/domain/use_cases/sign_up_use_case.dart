// features/sign_up/domain/use_cases/sign_up_use_case.dart

 import '../../../../../core/handleErrors/result_pattern.dart';
import '../../data/models/sign_up_model.dart';
import '../repositories/sign_up_repo_domain.dart';

class SignUpUseCase {
  final SignUpDomainRepo repository;

  SignUpUseCase(this.repository);
  Result<bool> checkValidation(SignUpModel request) {
    return repository.validateRatingRequest(request);
  }
  Future<Result> call(SignUpModel request) {
    return repository.signUp(request);
  }
}