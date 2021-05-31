import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_provider/constant/firestore_keys.dart';

class UserModel {
  final String message;
  final List<dynamic> friendmessage;
  final String email;
  final String username;
  final List<dynamic> friendname;
  final String userKey;
  final List<dynamic> friend;
  final int friendcount;
  final int myfriendcount;
  final String backImage;
  final DocumentReference reference;

  UserModel.fromMap(Map<String, dynamic> map, this.userKey, {this.reference})
      : message = map[KEY_USER_MESSEAGE],
        friendmessage = map[KEY_FRIEND_MESSEAGE],
        backImage = map[KEY_BACKIMG],
        email = map[KEY_EMAIL],
        friend = map[KEY_FRIEND],
        friendcount = map[KEY_FRIENDCOUNT],
        myfriendcount = map[KEY_MYFRIENDCOUNT],
        username =
            map[KEY_USERNAME] == null ? map[KEY_EMAIL] : map[KEY_USERNAME],
        friendname = map[KEY_FRIEND_NAME];


  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), snapshot.id,
            reference: snapshot.reference);

  static Map<String, dynamic> getMapForCreateUser(
      String email) {
    Map<String, dynamic> map = Map();
    map[KEY_FRIENDCOUNT]=0;
    map[KEY_MYFRIENDCOUNT]=0;
    map[KEY_FRIEND]=[];
    map[KEY_FRIEND_NAME]=[];
    map[KEY_BACKIMG]="";
    map[KEY_FRIEND_MESSEAGE]=[];
    map[KEY_USER_MESSEAGE] = "";
    map[KEY_EMAIL] = email;
    map[KEY_USERNAME] =
        map[KEY_USERNAME] == null ? map[KEY_EMAIL] : email.split("@")[0];
    return map;
  }
}
