import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/user.dart';
import 'package:recipy_frontend/pages/user/profile/profile_page.dart';

import 'profile_model.dart';

class ProfileControllerImpl extends ProfileController {
  late ProfileRepository _repository;

  ProfileControllerImpl(ProfileModel state) : super(state) {
    final container = ProviderContainer();
    _repository = container.read(profileRepositoryProvider);
    init();
  }

  Future<void> init() async {
    User? user = await _repository.getCurrentUser();
    state = state.copyWith(
      displayName: user?.displayName ?? "",
      email: user?.email ?? "",
      userId: user?.userId ?? "",
    );
  }

  @override
  Future<void> logoutUser() async {
    await _repository.logoutUser();
  }
}

abstract class ProfileRepository {
  Future<User?> getCurrentUser();
  Future<void> logoutUser();
}
