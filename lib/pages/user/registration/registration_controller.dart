import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';

import 'registration_model.dart';
import 'registration_page.dart';

class RegistrationControllerImpl extends RegistrationController {
  late RegistrationRepository _repository;

  RegistrationControllerImpl(RegistrationModel state) : super(state) {
    final container = ProviderContainer();
    _repository = container.read(registrationRepositoryProvider);
  }

  @override
  void register(String username, String password) async {
    _repository.register(username, password);
  }
}

abstract class RegistrationRepository {
  Future<bool> register(String username, String password);
}
