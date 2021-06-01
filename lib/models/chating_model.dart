import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_provider/constant/firestore_keys.dart';

class ChatingModel{
  final String message;
  final String sendBy;
  final String RoomId;
  final DateTime sendTime;

  final DocumentReference reference;

  ChatingModel.fromMap(Map<String, dynamic> map, this.RoomId, {this.reference})
      :
        message= map[KEY_MESSAGE],
        sendBy= map[KEY_SENDMESSAGE],
        sendTime = map[KEY_CHATING_TIME] ==null?DateTime.now().toUtc():(map[KEY_CHATING_TIME]as Timestamp).toDate();


  ChatingModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
      snapshot.data(),snapshot.id,reference:snapshot.reference
  );

  static Map<String,dynamic> getMapForNewChtaing(String content){
    Map<String,dynamic> map =Map();

    map[KEY_MESSAGE]="";
    map[KEY_SENDMESSAGE]="";
    map[KEY_CHATING_TIME]=DateTime.now().toUtc();

    return map;

  }
}