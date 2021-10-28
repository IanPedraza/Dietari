import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/repositories/UserRepository.dart';

class GetUserListenerUseCase {
  final UserRepository userRepository;

  GetUserListenerUseCase({required this.userRepository});

  Stream<User?> invoke(String id) {
    return userRepository.getUserListener(id);
  }
}
