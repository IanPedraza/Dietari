import 'package:dietari/data/domain/ExternalUser.dart';

abstract class AuthDataSource {
  String? getUserId();
  Future<ExternalUser?> signInWithGoogle();
  Future<bool> signOut();
}
