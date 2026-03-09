import 'package:fodwa/core/handleErrors/result_pattern.dart';
import 'package:fodwa/features/profile/domain/entities/user_entity.dart';
import 'package:fodwa/features/profile/domain/repositories/profile_repo.dart';

class UploadProfileImageUseCase {
  final ProfileRepo repository;

  UploadProfileImageUseCase(this.repository);

  Future<Result<UserEntity>> call(String imagePath) async {
    return await repository.uploadProfileImage(imagePath);
  }
}
