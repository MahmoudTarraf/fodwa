import 'package:fodwa/core/handleErrors/result_pattern.dart';
import 'package:fodwa/features/profile/domain/entities/user_entity.dart';
import 'package:fodwa/features/profile/domain/repositories/profile_repo.dart';
import 'package:fodwa/features/profile/data/data_sources/profile_remote_ds.dart';
import 'package:fodwa/features/profile/data/models/user_model.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDS remoteDataSource;

  ProfileRepoImpl(this.remoteDataSource);

  @override
  Future<Result<UserEntity>> getProfile() async {
    return await remoteDataSource.getProfile();
  }

  @override
  Future<Result<UserEntity>> updateProfile(UserEntity user) async {
    return await remoteDataSource.updateProfile(user as UserModel);
  }

  @override
  Future<Result<UserEntity>> uploadProfileImage(String imagePath) async {
    return await remoteDataSource.uploadProfileImage(imagePath);
  }
}
