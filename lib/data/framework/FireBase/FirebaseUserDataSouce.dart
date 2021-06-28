import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietari/data/datasources/UserDataSource.dart';
import 'package:dietari/data/domain/User.dart';
import 'package:dietari/data/framework/Firebase/FirebaseConstants.dart';

class FirebaseUserDataSouce extends UserDataSource {
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
  Future<String?> addUser(User user) {
    final reference = _database.collection(USERS_COLLECTION);
    final userId = reference.doc().id;

    user.id = userId;

    return reference.doc(userId).set(user.toMap()).then((value) => userId);
  }
}
