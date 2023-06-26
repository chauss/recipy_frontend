import 'package:recipy_frontend/models/user.dart';
import 'package:recipy_frontend/pages/settings/settings_model.dart';
import 'package:recipy_frontend/pages/settings/settings_page.dart';
import 'package:recipy_frontend/pages/user/user_management_repository.dart';

class SettingsControllerImpl extends SettingsController {
  late UserManagementRepository _userManagementRepository;

  SettingsControllerImpl(
    SettingsModel state,
    UserManagementRepository userManagementRepository,
  ) : super(state) {
    _userManagementRepository = userManagementRepository;

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
