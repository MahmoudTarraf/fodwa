import '../../../../../../core/handleErrors/result_pattern.dart';
import '../../models/sign_up_model.dart';

abstract class SignUpRemoteDS {
  Result<bool> validateRequest(SignUpModel request);
  Future<Result> signUp(SignUpModel request);
  Future<Result> verifyEmailOtp({required String email, required String code});
}
