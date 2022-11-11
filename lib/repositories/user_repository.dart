import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipy_frontend/pages/user/login/login_controller.dart';
import 'package:recipy_frontend/pages/user/registration/registration_controller.dart';

class FirebaseUserRepository extends RegistrationRepository
    with LoginRepository {
  @override
  Future<UserCredential> register(String email, String password) async {
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<UserCredential> login(String email, String password) async {
    FirebaseAuth.instance.setLanguageCode("de");
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
