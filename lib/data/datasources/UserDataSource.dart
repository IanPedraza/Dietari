import 'package:dietari/data/domain/Test.dart';
import 'package:dietari/data/domain/User.dart';

abstract class UserDataSource {
  Future<User?> getUser(String id);
  Future<bool> addUser(User user);
  Future<Test?> getUserTest(String userId, String testId);
  Future<bool> addUserTest(String userId, Test test);
}
