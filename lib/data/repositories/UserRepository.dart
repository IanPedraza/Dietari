import 'package:dietari/data/datasources/UserDataSource.dart';
import 'package:dietari/data/domain/Test.dart';
import 'package:dietari/data/domain/User.dart';

class UserRepository {
  UserDataSource userDataSource;

  UserRepository({required this.userDataSource});

  Future<User?> getUser(String id) {
    return userDataSource.getUser(id);
  }

  Future<bool> addUser(User user) {
    return userDataSource.addUser(user);
  }

  Future<Test?> getUserTest(String userId, String testId) {
    return userDataSource.getUserTest(userId, testId);
  }

  Future<bool> addUserTest(String userId, Test test) {
    return userDataSource.addUserTest(userId, test);
  }
}
