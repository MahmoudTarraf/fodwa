import 'package:get_it/get_it.dart';
import 'package:fodwa/features/Auth/signUp/data/data_sources/remote/sign_up_rds.dart';
import 'package:fodwa/features/Auth/signUp/data/data_sources/remote/sign_up_remote_ds_imp.dart';
import 'package:fodwa/features/Auth/signUp/data/repositories/sign_up_domain_repo.dart';
import 'package:fodwa/features/Auth/signUp/domain/repositories/sign_up_repo_domain.dart';
import 'package:fodwa/features/Auth/signUp/domain/use_cases/sign_up_use_case.dart';
import 'package:fodwa/features/Auth/signUp/domain/use_cases/verify_registration_use_case.dart';
import 'package:fodwa/features/Auth/signUp/presentation/manager/sign_up_bloc.dart';
import 'package:fodwa/features/profile/domain/use_cases/upload_profile_image_use_case.dart';

void signUpDI(GetIt getIt) {
  getIt.registerLazySingleton<SignUpRemoteDS>(() => SignUpRemoteDSImp());

  getIt.registerLazySingleton<SignUpDomainRepo>(() => SignUpDataRepo(getIt()));

  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));

  getIt.registerLazySingleton(() => VerifyRegistrationUseCase(getIt()));

  getIt.registerFactory(
    () => SignUpBloc(
      signUpUseCase: getIt(),
      uploadProfileImageUseCase: getIt<UploadProfileImageUseCase>(),
    ),
  );
}
