import 'package:dietari/data/domain/Test.dart';
import 'package:dietari/data/repositories/UserRepository.dart';

class AddUserTestUseCase {
  final UserRepository userRepository;

  AddUserTestUseCase({required this.userRepository});

  Future<Test?> invoke(String userId, String testId) {
    return userRepository.getUserTest(userId, testId);
  }
}
