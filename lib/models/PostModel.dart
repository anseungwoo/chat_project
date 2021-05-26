import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_provider/constant/firestore_keys.dart';

class PostModel {
  final String postKey;
  final String userKey;
  final String username;
  final String profilImage;
  final String backImage;
  final List<dynamic> myPosts;
  final DateTime postTime;
  final DocumentReference reference;

  PostModel.fromMap(Map<String, dynamic> map, this.postKey, {this.reference})
      : userKey = map[KEY_USERKEY],
        username = map[KEY_USERNAME],
        profilImage = map[KEY_PROFILEIMG],
        myPosts = map[KEY_PROFILEIMG],
        postTime = map[KEY_POSTTIME] == null
            ? DateTime.now().toUtc()
            : (map[KEY_POSTTIME] as Timestamp).toDate(),
        backImage = map[KEY_BACKIMG];

  PostModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), snapshot.id,
            reference: snapshot.reference);

  static Map<String, dynamic> getMapForCreatePost(
      {String userKey, String username}) {
    Map<String, dynamic> map = Map();
    map[KEY_USERKEY] = userKey;
    map[KEY_USERNAME] = username;
    map[KEY_PROFILEIMG] = [];
    map[KEY_BACKIMG] = "";
    map[KEY_POSTTIME] = DateTime.now().toUtc();
    return map;
  }
}
