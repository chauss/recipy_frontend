import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:logging/logging.dart';
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
  static final log = Logger('FirebaseUserRepository');
  final firebase.FirebaseAuth _firebaseAuth = firebase.FirebaseAuth.instance;

  // TODO dont return firebase stuff
  @override
  Future<firebase.UserCredential> register(
      String email, String password) async {
    log.info("Registering user...");
    var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    log.info("Registration done. Resulting UserId=${userCredential.user?.uid}");
    return userCredential;
  }

  @override
  Future<void> login(String email, String password) async {
    log.info("Logging in user...");
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    log.info("User Login done. Resulting UserId=${userCredential.user?.uid}");
  }

  @override
  Future<User?> getCurrentUser() async {
    log.fine(
        "Checking for current user. UserId=${_firebaseAuth.currentUser?.uid}");
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
    log.info("Logging out user...");
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
    final userIsLoggedIn = _firebaseAuth.currentUser != null;
    log.fine("Checking if user is logged in => $userIsLoggedIn");
    return userIsLoggedIn;
  }
}
