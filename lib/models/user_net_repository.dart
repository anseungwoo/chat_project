import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_provider/constant/firestore_keys.dart';
import 'package:test_provider/constant/transformers.dart';
import 'package:test_provider/models/user_model.dart';

class UserNetRepository with Transformers{
  Future<void> attemptCreateUser({String userKey, String email,String messeage, String name}) async {
    //어디에 넣을지 정함
    final DocumentReference userRef = FirebaseFirestore.instance.collection(
        COLLECTION_USERS).doc(userKey);

    DocumentSnapshot snapshot = await userRef.get();
    if (!snapshot.exists) //안에 존재하는지 안하는지
        {
      return await userRef.set(UserModel.getMapForCreateUser(email, messeage, name));
    }
  }
  Future<void> namecommet({String userKey,String name, String commet}) async {
    final DocumentReference ncRef =
    FirebaseFirestore.instance.collection(COLLECTION_USERS).doc(userKey);
    final DocumentSnapshot ncSnapshot = await ncRef.get();


    await ncRef.update({KEY_USERNAME:name,KEY_USER_MESSEAGE:commet});

  }


  Stream<UserModel> getUserModelStream(String userKey) {
    return FirebaseFirestore.instance.collection(COLLECTION_USERS)
        .doc(userKey)
        .snapshots().transform(toUser);
  }

}

UserNetRepository userNetRepository = UserNetRepository();
