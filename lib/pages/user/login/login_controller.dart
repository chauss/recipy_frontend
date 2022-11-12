import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';

import 'login_model.dart';
import 'login_page.dart';

class FirebaseLoginController extends LoginController {
  late LoginRepository _repository;

  FirebaseLoginController(LoginModel state) : super(state) {
    final container = ProviderContainer();
    _repository = container.read(loginRepositoryProvider);
  }

  @override
  Future<void> login(String email, String password) async {
    if (email == "") {
      state = state.copyWith(errorCode: "invalid_email");
      return;
    } else if (password == "") {
      state = state.copyWith(errorCode: "wrong_password");
      return;
    }

    try {
      state = state.copyWith(loginInProgress: true);
      await _repository.login(email, password);
      state =
          state.copyWith(successfullyLoggedIn: true, loginInProgress: false);
    } on FirebaseAuthException catch (e) {
      String? errorCode;
      if (e.code == "user-disabled") {
        errorCode = "user_disabled";
      } else if (e.code == "invalid-email") {
        errorCode = "invalid_email";
      } else if (e.code == "user-not-found") {
        errorCode = "user_not_found";
      } else if (e.code == "wrong-password:") {
        errorCode = "wrong_password:";
      } else if (e.code == "too-many-requests") {
        errorCode = "too_many_requests";
      } else {
        errorCode = e.code;
      }
      state = state.copyWith(loginInProgress: false, errorCode: errorCode);
    }
  }

  @override
  void dismissError() {
    state = state.copyWith(errorCode: null);
  }
}

abstract class LoginRepository {
  Future<UserCredential> login(String email, String password);
}
