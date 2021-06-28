import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/repositories/UserRepository.dart';

class GetUserUseCase {
  final UserRepository userRepository;

  GetUserUseCase({required this.userRepository});

  Future<User?> invoke(String id) {
    return userRepository.getUser(id);
  }
}
