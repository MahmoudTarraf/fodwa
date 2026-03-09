import '../../../../../core/handleErrors/result_pattern.dart';
import '../../domain/repositories/sign_up_repo_domain.dart';
import '../data_sources/remote/sign_up_rds.dart';
import '../models/sign_up_model.dart';

class SignUpDataRepo implements SignUpDomainRepo {
  final SignUpRemoteDS remoteDS;

  SignUpDataRepo(this.remoteDS);
  @override
  Result<bool> validateRatingRequest(SignUpModel request) {
    return remoteDS.validateRequest(request);
  }

  @override
  Future<Result> signUp(SignUpModel request) {
    return remoteDS.signUp(request);
  }

  @override
  Future<Result> verifyEmailOtp({required String email, required String code}) {
    return remoteDS.verifyEmailOtp(email: email, code: code);
  }
}
