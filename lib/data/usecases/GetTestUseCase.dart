import 'package:dietari/data/domain/Test.dart';
import 'package:dietari/data/repositories/TestsRepository.dart';

class GetTestUseCase {
  final TestsRepository testsRepository;

  GetTestUseCase({required this.testsRepository});

  Future<Test?> invoke(String testId) {
    return testsRepository.getTest(testId);
  }
}
