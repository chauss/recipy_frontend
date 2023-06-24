import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:recipy_frontend/models/user.dart';
import 'package:recipy_frontend/pages/user/login/login_controller.dart';
import 'package:recipy_frontend/pages/user/profile/profile_controller.dart';
import 'package:recipy_frontend/pages/user/registration/registration_controller.dart';
import 'package:recipy_frontend/pages/user/user_management_repository.dart';

class FirebaseUserRepository
    implements
        RegistrationRepository,
        LoginRepository,
        ProfileRepository,
        UserManagementRepository {
  final firebase.FirebaseAuth _firebaseAuth = firebase.FirebaseAuth.instance;

  // TODO dont return firebase stuff
  @override
  Future<firebase.UserCredential> register(
      String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> login(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<User?> getCurrentUser() async {
    var firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return User(
        email: firebaseUser.email ?? "anonymous",
        userId: firebaseUser.uid,
        displayName: firebaseUser.displayName ?? "",
        authToken: await firebaseUser.getIdToken(),
      );
    }
    return null;
  }

  @override
  Future<void> logoutUser() async {
    await _firebaseAuth.signOut();
  }

  @override
  void addOnUserStateChangedListener(UserChangedCalback callback) {
    _firebaseAuth.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser != null) {
        callback(
          User(
            email: firebaseUser.email ?? "anonymous",
            userId: firebaseUser.uid,
            displayName: firebaseUser.displayName ?? "",
            authToken: await firebaseUser.getIdToken(),
          ),
        );
      } else {
        callback(null);
      }
    });
  }

  @override
  bool isUserLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }
}
