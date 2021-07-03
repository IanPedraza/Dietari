import 'package:dietari/data/domain/ExternalUser.dart';
import 'package:dietari/data/repositories/AuthRepository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository authRepository;

  SignInWithGoogleUseCase({required this.authRepository});

  Future<ExternalUser?> invoke() {
    return authRepository.signInWithGoogle();
  }
}
