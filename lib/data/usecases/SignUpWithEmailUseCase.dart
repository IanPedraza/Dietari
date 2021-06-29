import 'package:dietari/data/repositories/AuthRepository.dart';

class SignUpWithEmailUseCase {
  final AuthRepository authRepository;

  SignUpWithEmailUseCase({required this.authRepository});

  Future<String?> invoke(String email, String password) {
    return authRepository.signUpWithEmail(email, password);
  }
}
