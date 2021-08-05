import 'package:dietari/data/domain/Test.dart';
import 'package:dietari/data/repositories/UserRepository.dart';

class GetUserTestUseCase {
  final UserRepository userRepository;

  GetUserTestUseCase({required this.userRepository});

  Future<bool> invoke(String userId, Test test) {
    return userRepository.addUserTest(userId, test);
  }
}