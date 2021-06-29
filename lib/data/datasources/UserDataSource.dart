import 'package:dietari/data/domain/User.dart';

abstract class UserDataSource {
  Future<User?> getUser(String id);
  Future<bool> addUser(User user);
}
