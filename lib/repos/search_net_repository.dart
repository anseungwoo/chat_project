import 'package:cloud_firestore/cloud_firestore.dart';


class SearchNetRepositoy {
 searchStream(String userKey) async{
    return FirebaseFirestore.instance
        .collection("store")
        .doc(userKey)
        .snapshots();
  }
}


SearchNetRepositoy searchNetRepositoy =SearchNetRepositoy();