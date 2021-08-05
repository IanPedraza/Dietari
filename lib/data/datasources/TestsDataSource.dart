import 'package:dietari/data/domain/Test.dart';

abstract class TestsDataSource {
  Future<Test?> getTest(String testId);
  Future<bool> addTest(Test test);
}
