import 'package:dietari/data/domain/Test.dart';

abstract class TestsDataSource {
  Future<Test?> getTest(String testId);
  Future<List<Test>> getTests();
  Future<bool> addTest(Test test);
}
