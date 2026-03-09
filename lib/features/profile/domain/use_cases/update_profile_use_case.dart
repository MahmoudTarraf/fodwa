import 'package:fodwa/core/handleErrors/result_pattern.dart';
import 'package:fodwa/features/profile/domain/entities/user_entity.dart';
import 'package:fodwa/features/profile/domain/repositories/profile_repo.dart';

class UpdateProfileUseCase {
  final ProfileRepo repository;

  UpdateProfileUseCase(this.repository);

  Future<Result<UserEntity>> call(UserEntity user) async {
    return await repository.updateProfile(user);
  }
}
