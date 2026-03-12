import 'package:fodwa/core/handleErrors/result_pattern.dart';
import 'package:fodwa/features/profile/domain/entities/user_entity.dart';

abstract class ProfileRepo {
  Future<Result<UserEntity>> getProfile();
  Future<Result<UserEntity>> updateProfile(UserEntity user);
  Future<Result<UserEntity>> partialUpdateProfile(Map<String, dynamic> data);
  Future<Result<UserEntity>> uploadProfileImage(String imagePath);
}
