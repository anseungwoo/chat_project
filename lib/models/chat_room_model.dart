import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_provider/constant/firestore_keys.dart';
import 'package:test_provider/models/user_model.dart';

class ChatRoomModel{
  final String roomkey;
  final List<UserModel> userkeys;
  final DateTime lastchatingTime;
  final String roomname;
  final String lastchat;
  final String roomImg;

  final DocumentReference reference;

  ChatRoomModel.fromMap(Map<String, dynamic> map, this.roomkey, {this.reference})
      :
        roomname=map[KEY_ROOMNAME],
        lastchat=map[KEY_LAST_CHAT],
        roomImg=map[KEY_ROOM_IMG],
        userkeys=map[KEY_USERKEYS],
        lastchatingTime = map[KEY_LAST_CHATTIME] ==null?DateTime.now().toUtc():(map[KEY_LAST_CHATTIME]as Timestamp).toDate();


  ChatRoomModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
      snapshot.data(),snapshot.id,reference:snapshot.reference
  );

  static Map<String,dynamic> getMapForNewChtaingRoom(String roomkey){
    Map<String,dynamic> map =Map();
    map[KEY_ROOMNAME]=roomkey;
    map[KEY_LAST_CHAT]="";
    map[KEY_ROOM_IMG]="";
    map[KEY_USERKEYS]=[];
    map[KEY_LAST_CHATTIME]=DateTime.now().toUtc();

    return map;

  }
}