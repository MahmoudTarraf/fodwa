import 'package:get_it/get_it.dart';
import 'package:fodwa/features/Auth/login/data/data_sources/remote/loginRDS.dart';
import 'package:fodwa/features/Auth/login/data/data_sources/remote/loginRDSImpl.dart';
import 'package:fodwa/features/Auth/login/data/repositories/loginDataImp.dart';
import 'package:fodwa/features/Auth/login/domain/repositories/loginDomainRepo.dart';
import 'package:fodwa/features/Auth/login/domain/use_cases/forget_password_use_case.dart';
import 'package:fodwa/features/Auth/login/domain/use_cases/login_use_case.dart';
import 'package:fodwa/features/Auth/login/presentation/bloc/bloc.dart';

void initialLoginDI(GetIt getIt) {
  // Data source
  getIt.registerLazySingleton<LoginRDS>(() => LoginRDSImpl());

  // Repository
  getIt.registerLazySingleton<LoginDomainRepo>(
    () => LoginDataRepoImpl(getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => ForgetPasswordUseCase(getIt()));

  // Bloc
  getIt.registerFactory(
    () => LoginBloc(
      loginUseCase: getIt(),
      forgetPasswordUseCase: getIt(),
      verifyRegistrationUseCase: getIt(),
      uploadProfileImageUseCase: getIt(),
    ),
  );
}
