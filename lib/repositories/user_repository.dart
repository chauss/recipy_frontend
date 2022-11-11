import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipy_frontend/pages/user/login/login_controller.dart';
import 'package:recipy_frontend/pages/user/registration/registration_controller.dart';

class FirebaseUserRepository extends RegistrationRepository
    with LoginRepository {
  @override
  Future<bool> register(String username, String password) {
    return Future.value(true);
  }

  @override
  Future<bool> login(String username, String password) {
    return Future.value(true);
  }
}
