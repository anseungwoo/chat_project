import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:test_provider/constant/firestore_keys.dart';
import 'package:test_provider/constant/transformers.dart';

class ChatNetRepositoy with Transformers {
  getConversationMessages(String chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection(COLLECTION_CHAT_ROOM)
        .doc(chatRoomId)
        .collection(COLLECTION_CHATING)
        .orderBy("chating_time",descending: true)
        .snapshots();
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection(COLLECTION_CHAT_ROOM)
        .doc(chatRoomId)
        .collection(COLLECTION_CHATING)
        .add(messageMap);
  }
}

ChatNetRepositoy chatNetRepositoy = ChatNetRepositoy();
