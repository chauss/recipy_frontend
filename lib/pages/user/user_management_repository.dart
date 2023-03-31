import 'package:recipy_frontend/models/user.dart';

typedef UserChangedCalback = Function(User? newUser);

abstract class UserManagementRepository {
  bool isUserLoggedIn();
  Future<void> logoutUser();
  Future<User?> getCurrentUser();
  void addOnUserStateChangedListener(UserChangedCalback callback);
}
