import 'package:dietari/data/domain/Tip.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/domain/UserTest.dart';

abstract class UserDataSource {
  Future<User?> getUser(String id);
  Future<bool> addUser(User user);
  Future<UserTest?> getUserTest(String userId, String testId);
  Future<bool> addUserTest(String userId, UserTest test);
  Future<List<Tip>> getUserTips(String userId);
}
