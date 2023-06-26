import 'package:recipy_frontend/models/user.dart';
import 'package:recipy_frontend/pages/app_screen/app_screen_page.dart';
import 'package:recipy_frontend/pages/user/user_management_repository.dart';

class AppScreenControllerImpl extends AppScreenController {
  late UserManagementRepository _userManagementRepository;

  AppScreenControllerImpl(
      super.state, UserManagementRepository userManagementRepository) {
    _userManagementRepository = userManagementRepository;
    _userManagementRepository.addOnUserStateChangedListener(_onUserChanged);

    _init();
  }

  void _init() async {
    _onUserChanged(await _userManagementRepository.getCurrentUser());
  }

  void _onUserChanged(User? newUser) {
    state = state.copyWith(
      isUserLoggedIn: newUser != null,
    );
  }

  @override
  void setCurrentIndexPage(int pageIndex) {
    if (pageIndex != state.currentPageIndex) {
      state = state.copyWith(
        currentPageIndex: pageIndex,
      );
    }
  }
}
