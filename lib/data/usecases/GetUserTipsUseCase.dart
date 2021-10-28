import 'package:dietari/data/domain/Tip.dart';
import 'package:dietari/data/repositories/UserRepository.dart';

class GetUserTipsUseCase {
  final UserRepository userRepository;

  GetUserTipsUseCase({required this.userRepository});

  Stream<List<Tip>> invoke(String userId) {
    return userRepository.getUserTips(userId);
  }
}
