import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/repositories/UserRepository.dart';

class AddUserUseCase {
  final UserRepository userRepository;

  AddUserUseCase({required this.userRepository});

  Future<bool> invoke(User user) {
    return userRepository.addUser(user);
  }
}
