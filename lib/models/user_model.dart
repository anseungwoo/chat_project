import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_provider/constant/firestore_keys.dart';

class UserModel {
  final String message;
  final String userImg;
  final String email;
  final String username;
  final String userKey;
  final DocumentReference reference;

  UserModel.fromMap(Map<String, dynamic> map, this.userKey, {this.reference})
      : message = map[KEY_USER_MESSEAGE],
        userImg = map[KEY_PROFILEIMG],
        email = map[KEY_EMAIL],
        username = map[KEY_USERNAME]==null?map[KEY_EMAIL]:map[KEY_USERNAME];

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
          snapshot.data(),snapshot.id,reference:snapshot.reference
        );

  static Map<String,dynamic> getMapForCreateUser(String email,String messeage,String name){
    Map<String,dynamic> map =Map();
    map[KEY_USER_MESSEAGE]=messeage;
    map[KEY_PROFILEIMG]="";
    map[KEY_EMAIL]=email;
    map[KEY_USERNAME]=map[KEY_USERNAME]==null?map[KEY_EMAIL]:map[KEY_USERNAME];
    return map;

  }
}
