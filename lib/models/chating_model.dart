import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_provider/constant/firestore_keys.dart';

class ChatingModel{
  final String username;
  final String userKey;
  final String chating;
  final DateTime chatingTime;
  final String chatingKey;
  final DocumentReference reference;

  ChatingModel.fromMap(Map<String, dynamic> map, this.chatingKey, {this.reference})
      : userKey = map[KEY_USERKEY],
        chating = map[KEY_CHATING],
        chatingTime = map[KEY_CHATING_TIME] ==null?DateTime.now().toUtc():(map[KEY_CHATING_TIME]as Timestamp).toDate(),
        username = map[KEY_USERNAME];

  ChatingModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
      snapshot.data(),snapshot.id,reference:snapshot.reference
  );

  static Map<String,dynamic> getMapForNewChtaing(String userKey,String username,String chating){
    Map<String,dynamic> map =Map();
    map[KEY_USERKEY]=userKey;
    map[KEY_CHATING]=chating;
    map[KEY_CHATING_TIME]=DateTime.now().toUtc();
    map[KEY_USERNAME]=username;
    return map;

  }
}