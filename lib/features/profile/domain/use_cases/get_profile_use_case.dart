import 'package:fodwa/core/handleErrors/result_pattern.dart';
import 'package:fodwa/features/profile/domain/entities/user_entity.dart';
import 'package:fodwa/features/profile/domain/repositories/profile_repo.dart';

class GetProfileUseCase {
  final ProfileRepo repository;

  GetProfileUseCase(this.repository);

  Future<Result<UserEntity>> call() async {
    return await repository.getProfile();
  }
}
