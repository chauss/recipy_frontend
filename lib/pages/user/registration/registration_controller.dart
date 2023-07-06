import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipy_frontend/config/app_config.dart';

import 'registration_model.dart';
import 'registration_page.dart';

class FirebaseRegistrationController extends RegistrationController {
  late RegistrationRepository _repository;

  FirebaseRegistrationController(
    RegistrationRepository registrationRepository,
  ) : super(const RegistrationModel()) {
    _repository = registrationRepository;
  }

  @override
  Future<void> register(
      String email, String password, String displayName) async {
    if (email == "") {
      state = state.copyWith(errorCode: "invalid_email");
      return;
    } else if (password == "") {
      state = state.copyWith(errorCode: "weak_password");
      return;
    } else if (displayName == "" || displayName.length < displayNameMinLenght) {
      state = state.copyWith(errorCode: "display_name_too_short");
      return;
    }

    try {
      state = state.copyWith(registrationInProgress: true);
      UserCredential userCredentials =
          await _repository.register(email, password);
      await userCredentials.user?.updateDisplayName(displayName);
      await userCredentials.user?.sendEmailVerification();
      state = state.copyWith(
          registrationInProgress: false, successfullyRegistered: true);
    } on FirebaseAuthException catch (e) {
      String? errorCode;
      if (e.code == "email-already-in-use") {
        errorCode = "email_already_in_use";
      } else if (e.code == "invalid-email") {
        errorCode = "invalid_email";
      } else if (e.code == "operation-not-allowed") {
        errorCode = "operation_not_allowed";
      } else if (e.code == "weak-password") {
        errorCode = "weak_password";
      } else {
        errorCode = e.code;
      }
      state =
          state.copyWith(registrationInProgress: false, errorCode: errorCode);
    }
  }

  @override
  void dismissError() {
    state = state.copyWith(errorCode: null);
  }
}

abstract class RegistrationRepository {
  Future<UserCredential> register(String email, String password);
}
