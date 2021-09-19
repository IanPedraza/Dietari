import 'package:dietari/data/domain/Test.dart';
import 'package:dietari/data/repositories/TestsRepository.dart';

class GetTestsUseCase {
  final TestsRepository testsRepository;

  GetTestsUseCase({required this.testsRepository});

  Future<List<Test>> invoke() {
    return testsRepository.getTests();
  }
}
