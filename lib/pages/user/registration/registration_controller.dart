import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';

import 'registration_model.dart';
import 'registration_page.dart';

class FirebaseRegistrationController extends RegistrationController {
  late RegistrationRepository _repository;

  FirebaseRegistrationController(RegistrationModel state) : super(state) {
    final container = ProviderContainer();
    _repository = container.read(registrationRepositoryProvider);
  }

  @override
  Future<void> register(String email, String password) async {
    if (email == "") {
      state = state.copyWith(errorCode: "invalid_email");
      return;
    } else if (password == "") {
      state = state.copyWith(errorCode: "weak_password");
      return;
    }

    try {
      state = state.copyWith(registrationInProgress: true);
      await _repository.register(email, password);
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
  Future<void> register(String email, String password);
}
