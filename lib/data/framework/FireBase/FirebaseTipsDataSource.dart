import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dietari/data/datasources/TipsDataSource.dart';
import 'package:dietari/data/domain/Tip.dart';
import 'package:dietari/data/framework/FireBase/FirebaseConstants.dart';

class FirebaseTipsDataSource extends TipsDataSource {
  static const TAG = "FirebaseTipsDataSource";

  FirebaseFirestore _database = FirebaseFirestore.instance;

  @override
  Future<Tip?> getTip(tipId) async {
    try {
      final snapshot =
          await _database.collection(COLLECTION_TIPS).doc(tipId).get();

      if (!snapshot.exists || snapshot.data() == null) {
        return null;
      }

      final tip = Tip.fromMap(snapshot.data()!);

      return tip;
    } catch (error) {
      print("$TAG:getTip:Error: $error");
      return null;
    }
  }
}
