import 'package:dietari/data/domain/Test.dart';
import 'package:dietari/data/repositories/TestsRepository.dart';

class AddTestUseCase {
  final TestsRepository testsRepository;

  AddTestUseCase({required this.testsRepository});

  Future<bool> invoke(Test test) {
    return testsRepository.addTest(test);
  }
}
