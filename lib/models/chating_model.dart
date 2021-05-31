import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_provider/constant/firestore_keys.dart';

class ChatingModel{
  final String content;
  final DateTime sendTime;

  final DocumentReference reference;

  ChatingModel.fromMap(Map<String, dynamic> map, this.content, {this.reference})
      :
        sendTime = map[KEY_CHATING_TIME] ==null?DateTime.now().toUtc():(map[KEY_CHATING_TIME]as Timestamp).toDate();


  ChatingModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
      snapshot.data(),snapshot.id,reference:snapshot.reference
  );

  static Map<String,dynamic> getMapForNewChtaing(String content){
    Map<String,dynamic> map =Map();
    map[KEY_CHATING_TIME]=DateTime.now().toUtc();

    return map;

  }
}