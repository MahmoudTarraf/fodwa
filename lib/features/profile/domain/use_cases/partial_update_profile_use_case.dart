import 'package:fodwa/core/handleErrors/result_pattern.dart';
import 'package:fodwa/features/profile/domain/entities/user_entity.dart';
import 'package:fodwa/features/profile/domain/repositories/profile_repo.dart';

class PartialUpdateProfileUseCase {
  final ProfileRepo repository;

  PartialUpdateProfileUseCase(this.repository);

  Future<Result<UserEntity>> call(Map<String, dynamic> data) async {
    return await repository.partialUpdateProfile(data);
  }
}
