import 'package:dietari/data/repositories/AuthRepository.dart';

class SignOutUseCase {
  final AuthRepository authRepository;

  SignOutUseCase({required this.authRepository});

  Future<bool> invoke() {
    return authRepository.signOut();
  }
}
