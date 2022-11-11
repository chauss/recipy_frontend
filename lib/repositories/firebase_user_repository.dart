import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:recipy_frontend/models/user.dart';
import 'package:recipy_frontend/pages/user/login/login_controller.dart';
import 'package:recipy_frontend/pages/user/profile/profile_controller.dart';
import 'package:recipy_frontend/pages/user/registration/registration_controller.dart';
import 'package:recipy_frontend/pages/user/user_management_repository.dart';

class FirebaseUserRepository extends RegistrationRepository
    with LoginRepository, UserManagementRepository, ProfileRepository {
  final firebase.FirebaseAuth _firebaseAuth = firebase.FirebaseAuth.instance;

  @override
  Future<firebase.UserCredential> register(
      String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<firebase.UserCredential> login(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  bool isUserLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  @override
  User? getCurrentUser() {
    if (_firebaseAuth.currentUser != null) {
      return User(
          email: _firebaseAuth.currentUser?.email ?? "anonymous",
          userId: _firebaseAuth.currentUser?.uid ?? "");
    }
    return null;
  }

  @override
  Future<void> logoutUser() async {
    await _firebaseAuth.signOut();
  }
}
