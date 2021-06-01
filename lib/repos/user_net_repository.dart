import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_provider/constant/firestore_keys.dart';
import 'package:test_provider/constant/transformers.dart';
import 'package:test_provider/models/user_model.dart';

class UserNetRepository with Transformers {
  Future<void> attemptCreateUser({String userKey, String email}) async {
    final DocumentReference userRef =
        FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey);

    DocumentSnapshot snapshot = await userRef.get();
    if (!snapshot.exists) {
      return await userRef.set(UserModel.getMapForCreateUser(email));
    }
  }



  Future<void> namecommet({String userKey, String name, String commet}) async {
    final DocumentReference ncRef =
        FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey);
    final DocumentSnapshot ncSnapshot = await ncRef.get();

    await ncRef.update({KEY_USERNAME: name, KEY_USER_MESSEAGE: commet});
  }
  Future<void> composts({String userKey, String post}) async {
    final DocumentReference ncRef =
        FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey);
    final DocumentSnapshot ncSnapshot = await ncRef.get();

    await ncRef.update({KEY_PROFILEIMG: post});
  }
  Future<void> baposts({String userKey, String post}) async {
    final DocumentReference ncRef =
    FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey);
    final DocumentSnapshot ncSnapshot = await ncRef.get();

    await ncRef.update({KEY_BACKIMG: post});
  }

  Stream<List<UserModel>> getAllUser() {
    return FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .snapshots()
        .transform(toUsers);
  }


  Stream<List<UserModel>> getUser(List<dynamic> followings) {
    final CollectionReference collectionRefernce =
    FirebaseFirestore.instance.collection(COLLECTION_USERS);
    List<Stream<List<UserModel>>> streams = [];
    for (final following in followings) {
      streams.add(collectionRefernce.where(KEY_FRIEND,isEqualTo: following)
          .snapshots()
          .transform(toUsers));
    }
    return CombineLatestStream.list<List<UserModel>>(streams)
        .transform(combineListOfUser);
  }





  Stream<UserModel> getUserModelStream(String userKey) {
    return FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(userKey)
        .snapshots()
        .transform(toUser);
  }

  Stream<List<UserModel>> fetchUserFromAllFollowers(List<dynamic> followings) {
    final CollectionReference collectionRefernce =
    FirebaseFirestore.instance.collection(COLLECTION_USERS);
    List<Stream<List<UserModel>>> streams = [];

    for (final following in followings) {
      streams.add(collectionRefernce
          .where(KEY_USERKEY, isEqualTo: following)
          .snapshots()
          .transform(touser));
    }
    return CombineLatestStream.list<List<UserModel>>(streams)
        .transform(combineListOfUser);
  }

  Future<void> addUser({String myUserKey, String otherUserKey}) async {
    final DocumentReference myUserRef =
        FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(myUserKey);
    final DocumentSnapshot mySnapshot = await myUserRef.get();
    final DocumentReference otherUserRef = FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(otherUserKey);
    final DocumentSnapshot otherSnapshot = await otherUserRef.get();

    FirebaseFirestore.instance.runTransaction((tx) async {
      if (mySnapshot.exists && otherSnapshot.exists) {
        tx.update(myUserRef, {
          KEY_FRIEND: FieldValue.arrayUnion([otherUserKey])
        });
        tx.update(otherUserRef, {
          KEY_FRIEND: FieldValue.arrayUnion([myUserKey])
        });
        int currenCount = otherSnapshot.get(KEY_FRIENDCOUNT);
        int currenCount1 = mySnapshot.get(KEY_MYFRIENDCOUNT);
        tx.update(otherUserRef, {KEY_FRIENDCOUNT: currenCount + 1});
        tx.update(myUserRef, {KEY_MYFRIENDCOUNT: currenCount1 + 1});
      }
    });
  }
  Future<void> addCUser({String myUserKey, String otherUserKey}) async {
    final DocumentReference myUserRef =
    FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(myUserKey);
    final DocumentSnapshot mySnapshot = await myUserRef.get();
    final DocumentReference otherUserRef = FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(otherUserKey);
    final DocumentSnapshot otherSnapshot = await otherUserRef.get();

    FirebaseFirestore.instance.runTransaction((tx) async {
      if (mySnapshot.exists && otherSnapshot.exists) {
        tx.update(myUserRef, {
          KEY_FRIEND: FieldValue.arrayUnion([otherUserKey])
        });
        tx.update(otherUserRef, {
          KEY_FRIEND: FieldValue.arrayUnion([myUserKey])
        });
        int currenCount = otherSnapshot.get(KEY_MYFRIENDCOUNT);
        int currenCount1 = mySnapshot.get(KEY_FRIENDCOUNT);
        tx.update(otherUserRef, {KEY_MYFRIENDCOUNT: currenCount + 1});
        tx.update(myUserRef, {KEY_FRIENDCOUNT: currenCount1 + 1});
      }
    });
  }

  Future<void> unaddUser({String myUserKey, String otherUserKey}) async {
    final DocumentReference myUserRef =
        FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(myUserKey);
    final DocumentSnapshot mySnapshot = await myUserRef.get();
    final DocumentReference otherUserRef = FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(otherUserKey);
    final DocumentSnapshot otherSnapshot = await otherUserRef.get();

    FirebaseFirestore.instance.runTransaction((tx) async {
      if (mySnapshot.exists && otherSnapshot.exists) {
        tx.update(myUserRef, {
          KEY_FRIEND: FieldValue.arrayRemove([otherUserKey])
        });
        tx.update(otherUserRef, {
          KEY_FRIEND: FieldValue.arrayRemove([myUserKey])
        });
        int currenCount = otherSnapshot.get(KEY_FRIENDCOUNT);
        int currenCount1 = mySnapshot.get(KEY_MYFRIENDCOUNT);
        tx.update(otherUserRef, {KEY_FRIENDCOUNT: currenCount - 1});
        tx.update(myUserRef, {KEY_MYFRIENDCOUNT: currenCount1 - 1});

      }
    });
  }
  Future<void> unaddCUser({String myUserKey, String otherUserKey}) async {
    final DocumentReference myUserRef =
        FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(myUserKey);
    final DocumentSnapshot mySnapshot = await myUserRef.get();
    final DocumentReference otherUserRef = FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(otherUserKey);
    final DocumentSnapshot otherSnapshot = await otherUserRef.get();

    FirebaseFirestore.instance.runTransaction((tx) async {
      if (mySnapshot.exists && otherSnapshot.exists) {
        tx.update(myUserRef, {
          KEY_FRIEND: FieldValue.arrayRemove([otherUserKey])
        });
        tx.update(otherUserRef, {
          KEY_FRIEND: FieldValue.arrayRemove([myUserKey])
        });
        int currenCount = otherSnapshot.get(KEY_MYFRIENDCOUNT);
        int currenCount1 = mySnapshot.get(KEY_FRIENDCOUNT);
        tx.update(otherUserRef, {KEY_MYFRIENDCOUNT: currenCount - 1});
        tx.update(myUserRef, {KEY_FRIENDCOUNT: currenCount1 - 1});

      }
    });
  }
}

UserNetRepository userNetRepository = UserNetRepository();
