import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipy_frontend/helpers/providers.dart';
import 'package:recipy_frontend/models/user.dart';
import 'package:recipy_frontend/pages/home/home_page.dart';
import 'package:recipy_frontend/pages/user/user_management_repository.dart';

class HomeControllerImpl extends HomeController {
  late UserManagementRepository _userManagementRepository;

  HomeControllerImpl(super.state) {
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
    state = state.copyWith(
      isUserLoggedIn: newUser != null,
    );
  }

  @override
  void setCurrentIndexPage(int pageIndex) {
    state = state.copyWith(
      currentPageIndex: pageIndex,
    );
  }
}
