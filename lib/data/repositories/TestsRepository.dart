import 'package:dietari/data/datasources/TestsDataSource.dart';
import 'package:dietari/data/domain/Test.dart';

class TestsRepository {
  TestsDataSource testsDataSource;

  TestsRepository({required this.testsDataSource});

  Future<Test?> getTest(String testId) {
    return testsDataSource.getTest(testId);
  }

  Future<bool> addTest(Test test) {
    return testsDataSource.addTest(test);
  }
}
