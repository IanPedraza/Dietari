import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietari/data/datasources/UserDataSource.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/framework/Firebase/FirebaseConstants.dart';

class FirebaseUserDataSouce extends UserDataSource {
  static const TAG = "FirebaseUserDataSouce";

  FirebaseFirestore _database = FirebaseFirestore.instance;

  @override
  Future<User?> getUser(String id) async {
    final response = await _database.collection(USERS_COLLECTION).doc(id).get();

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
          .collection(USERS_COLLECTION)
          .doc(user.id)
          .set(user.toMap());

      return true;
    } catch (error) {
      print("$TAG:addUser:Error: $error");
      return false;
    }
  }
}
