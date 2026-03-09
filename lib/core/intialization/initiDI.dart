import 'package:get_it/get_it.dart';
import 'package:fodwa/features/Auth/login/di/login_di.dart';
import 'package:fodwa/features/Auth/signUp/di/signUpDi.dart';
import 'package:fodwa/features/profile/di/profile_di.dart';

final getIt = GetIt.instance;

Future<void> initDI() async {
  initialLoginDI(getIt);
  signUpDI(getIt);
  profileDI(getIt);
}
