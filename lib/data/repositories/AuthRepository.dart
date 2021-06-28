import 'package:dietari/data/datasources/AuthDataSource.dart';
import 'package:dietari/data/domain/ExternalUser.dart';

class AuthRepository {
  AuthDataSource authDataSource;

  AuthRepository({required this.authDataSource});

  Future<ExternalUser?> signInWithGoogle() {
    return authDataSource.signInWithGoogle();
  }

  Future<bool> signOut() {
    return authDataSource.signOut();
  }

  String? getUserId() {
    return authDataSource.getUserId();
  }
}
