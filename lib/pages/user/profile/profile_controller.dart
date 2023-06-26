import 'package:recipy_frontend/models/user.dart';
import 'package:recipy_frontend/pages/user/profile/profile_page.dart';
import 'package:recipy_frontend/pages/user/user_management_repository.dart';

import 'profile_model.dart';

class ProfileControllerImpl extends ProfileController {
  late ProfileRepository _repository;
  late UserManagementRepository _userManagementRepository;

  ProfileControllerImpl(
    ProfileModel state,
    ProfileRepository profileRepository,
    UserManagementRepository userManagementRepository,
  ) : super(state) {
    _repository = profileRepository;
    _userManagementRepository = userManagementRepository;

    _userManagementRepository.addOnUserStateChangedListener(_onUserChanged);

    init();
  }

  void _onUserChanged(User? newUser) {
    if (newUser == null) {
      state = state.copyWith(
        successfullyLoggedOut: true,
      );
    }
  }

  Future<void> init() async {
    User? user = await _repository.getCurrentUser();
    if (user != null) {
      state = state.copyWith(
        displayName: user.displayName,
        email: user.email,
        userId: user.userId,
      );
    } else {
      state = state.copyWith(successfullyLoggedOut: true);
    }
  }

  @override
  Future<void> logoutUser() async {
    if (state.logoutInProgress) {
      return;
    }
    state = state.copyWith(logoutInProgress: true);
    await _repository.logoutUser();
    state = state.copyWith(
      logoutInProgress: false,
      displayName: "",
      email: "",
      userId: "",
      successfullyLoggedOut: true,
    );
  }
}

abstract class ProfileRepository {
  Future<User?> getCurrentUser();
  Future<void> logoutUser();
}
