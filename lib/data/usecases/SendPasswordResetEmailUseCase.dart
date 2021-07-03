import 'package:dietari/data/repositories/AuthRepository.dart';

class SendPasswordResetEmailUseCase {
  final AuthRepository authRepository;

  SendPasswordResetEmailUseCase({required this.authRepository});

  Future<bool> invoke(String email) {
    return authRepository.sendPasswordResetEmail(email);
  }
}
