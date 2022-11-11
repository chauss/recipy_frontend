import 'package:recipy_frontend/models/user.dart';

abstract class UserManagementRepository {
  bool isUserLoggedIn();
  Future<void> logoutUser();
  User? getCurrentUser();
}
