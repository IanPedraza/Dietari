import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietari/data/datasources/TipsDataSource.dart';
import 'package:dietari/data/datasources/UserDataSource.dart';
import 'package:dietari/data/domain/HistoryItem.dart';
import 'package:dietari/data/domain/Tip.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/domain/UserTest.dart';
import 'package:dietari/data/framework/FireBase/FirebaseConstants.dart';
import 'package:dietari/data/framework/FireBase/FirebaseTipsDataSource.dart';
import 'package:dietari/data/repositories/TipsRepository.dart';
import 'package:dietari/data/usecases/GetTipsUseCase.dart';

class FirebaseUserDataSouce extends UserDataSource {
  static const TAG = "FirebaseUserDataSouce";

  FirebaseFirestore _database = FirebaseFirestore.instance;

  @override
  Future<User?> getUser(String id) async {
    final response = await _database.collection(COLLECTION_USERS).doc(id).get();

    if (response.exists && response.data() != null) {
      return User.fromMap(response.data()!);
    } else {
      return null;
    }
  }

  @override
  Future<bool> addUser(User user) async {
    try {
      await _database
          .collection(COLLECTION_USERS)
          .doc(user.id)
          .set(user.toMap());

      return true;
    } catch (error) {
      print("$TAG:addUser:Error: $error");
      return false;
    }
  }

  @override
  Future<UserTest?> getUserTest(String userId, String testId) async {
    try {
      final response = await _database
          .collection(COLLECTION_USERS)
          .doc(userId)
          .collection(COLLECTION_USERS_TESTS)
          .doc(testId)
          .get();

      if (response.exists && response.data() != null) {
        return UserTest.fromMap(response.data()!);
      } else {
        return null;
      }
    } catch (error) {
      print("$TAG:getUserTest:Error: $error");
      return null;
    }
  }

  @override
  Future<bool> addUserTest(String userId, UserTest test) async {
    try {
      if (test.id.isEmpty) {
        throw new Exception("Test id must not be empty");
      }

      await _database
          .collection(COLLECTION_USERS)
          .doc(userId)
          .collection(COLLECTION_USERS_TESTS)
          .doc(test.id)
          .set(test.toMap());

      return true;
    } catch (error) {
      print("$TAG:addUserTest:Error: $error");
      return false;
    }
  }

  @override
  Future<List<Tip>> getUserTips(String userId) async {
    try {
      if (userId.isEmpty) {
        throw new Exception("user id must not be empty");
      }

      final snapshot =
          await _database.collection(COLLECTION_USERS).doc(userId).get();

      if (!snapshot.exists) {
        return [];
      }

      final user = User.fromMap(snapshot.data()!);

      TipsDataSource tipsDataSource = FirebaseTipsDataSource();

      TipsRepository tipsRepository =
          TipsRepository(tipsDataSource: tipsDataSource);

      GetTipsUseCase getTipsUseCase =
          GetTipsUseCase(tipsRepository: tipsRepository);

      List<Tip> tips = [];

      List<Future<Tip?>> futures = [];

      user.tips.forEach((tipId) {
        Future<Tip?> future = getTipsUseCase.invoke(tipId);
        futures.add(future);
      });

      List<Tip?> results = await Future.wait(futures);

      results.forEach((tip) {
        if (tip != null) {
          tips.add(tip);
        }
      });

      return tips;
    } catch (error) {
      print("$TAG:getUserTips:Error: $error");
      return [];
    }
  }

  @override
  Future<List<HistoryItem>> getHistory(String userId) async {
    try {
      if (userId.isEmpty) {
        throw new Exception("user id must not be empty");
      }

      final snapshot = await _database
          .collection(COLLECTION_USERS)
          .doc(userId)
          .collection(COLLECTION_HISTORY)
          .get();

      List<HistoryItem> history = [];

      snapshot.docs.forEach((document) {
        if (document.exists) {
          HistoryItem historyItem = HistoryItem.fromMap(document.data());
          history.add(historyItem);
        }
      });

      return history;
    } catch (error) {
      print("$TAG:getHistory:Error: $error");
      return [];
    }
  }
}
