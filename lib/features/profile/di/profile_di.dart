import 'package:get_it/get_it.dart';
import 'package:fodwa/features/profile/data/data_sources/profile_remote_ds.dart';
import 'package:fodwa/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:fodwa/features/profile/domain/repositories/profile_repo.dart';
import 'package:fodwa/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:fodwa/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:fodwa/features/profile/domain/use_cases/upload_profile_image_use_case.dart';
import 'package:fodwa/features/profile/presentation/manager/profile_cubit.dart';

void profileDI(GetIt getIt) {
  // Data sources
  getIt.registerLazySingleton<ProfileRemoteDS>(() => ProfileRemoteDSImpl());

  // Repositories
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl(getIt()));

  // Use cases
  getIt.registerLazySingleton(() => GetProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => UploadProfileImageUseCase(getIt()));

  // Cubit
  getIt.registerFactory(() => ProfileCubit(getIt(), getIt(), getIt()));
}
