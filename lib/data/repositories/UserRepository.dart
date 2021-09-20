import 'package:dietari/data/datasources/UserDataSource.dart';
import 'package:dietari/data/domain/Tip.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/domain/UserTest.dart';

class UserRepository {
  UserDataSource userDataSource;

  UserRepository({required this.userDataSource});

  Future<User?> getUser(String id) {
    return userDataSource.getUser(id);
  }

  Future<bool> addUser(User user) {
    return userDataSource.addUser(user);
  }

  Future<UserTest?> getUserTest(String userId, String testId) {
    return userDataSource.getUserTest(userId, testId);
  }

  Future<bool> addUserTest(String userId, UserTest test) {
    return userDataSource.addUserTest(userId, test);
  }

  Future<List<Tip>> getUserTips(String userId) {
    return userDataSource.getUserTips(userId);
  }
}
