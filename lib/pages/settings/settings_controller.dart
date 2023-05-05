import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/user.dart';
import 'package:recipy_frontend/pages/settings/settings_model.dart';
import 'package:recipy_frontend/pages/settings/settings_page.dart';
import 'package:recipy_frontend/pages/user/user_management_repository.dart';

class SettingsControllerImpl extends SettingsController {
  late UserManagementRepository _userManagementRepository;

  SettingsControllerImpl(SettingsModel state) : super(state) {
    final container = ProviderContainer();
    _userManagementRepository =
        container.read(userManagementRepositoryProvider);

    _userManagementRepository.addOnUserStateChangedListener(_onUserChanged);

    _init();
  }

  void _init() async {
    _onUserChanged(await _userManagementRepository.getCurrentUser());
  }

  void _onUserChanged(User? newUser) {
    state = state.copyWith(username: newUser?.displayName);
  }
}
