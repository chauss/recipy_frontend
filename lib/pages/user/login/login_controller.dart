import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';

import 'login_model.dart';
import 'login_page.dart';

class LoginControllerImpl extends LoginController {
  late LoginRepository _repository;

  LoginControllerImpl(LoginModel state) : super(state) {
    final container = ProviderContainer();
    _repository = container.read(loginRepositoryProvider);
  }

  @override
  void login(String username, String password) async {
    _repository.login(username, password);
  }
}

abstract class LoginRepository {
  Future<bool> login(String username, String password);
}
