import 'package:dietari/data/datasources/UserDataSource.dart';
import 'package:dietari/data/domain/User.dart';

class UserRepository {
  UserDataSource userDataSource;

  UserRepository({required this.userDataSource});

  Future<User?> getUser(String id) {
    return userDataSource.getUser(id);
  }

  Future<String?> addUser(User user) {
    return userDataSource.addUser(user);
  }
}
