import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietari/data/datasources/TestsDataSource.dart';
import 'package:dietari/data/domain/Test.dart';

import 'FirebaseConstants.dart';

class FirebaseTestsDataSource extends TestsDataSource {
  static const TAG = "FirebaseTestsDataSource";

  FirebaseFirestore _database = FirebaseFirestore.instance;

  @override
  Future<bool> addTest(Test test) async {
    try {
      final _reference = _database.collection(TESTS_COLLECTION);
      final _testId = _reference.doc().id;

      test.id = _testId;

      await _reference.doc(_testId).set(test.toMap());

      return true;
    } catch (error) {
      print("$TAG:addTest:Error: $error");
      return false;
    }
  }

  @override
  Future<Test?> getTest(String testId) async {
    try {
      final response =
          await _database.collection(TESTS_COLLECTION).doc(testId).get();

      if (response.exists && response.data() != null) {
        return Test.fromMap(response.data()!);
      } else {
        return null;
      }
    } catch (error) {
      print("$TAG:getTest:Error: $error");
      return null;
    }
  }

  @override
  Future<List<Test>> getTests() async {
    try {
      final snapshots = await _database.collection(TESTS_COLLECTION).get();
      List<Test> tests = [];

      snapshots.docs.forEach((document) {
        final test = Test.fromMap(document.data());
        tests.add(test);
      });

      return tests;
    } catch (error) {
      print("$TAG:getTests:Error: $error");
      return [];
    }
  }
}
