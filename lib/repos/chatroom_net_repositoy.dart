import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_provider/constant/firestore_keys.dart';
import 'package:test_provider/constant/transformers.dart';
import 'package:test_provider/models/chat_room_model.dart';

class ChatRoomNetRepositoy with Transformers {
  Future<void> createChatRoom({String chatRoomID, chatRoomMap}) async {
    FirebaseFirestore.instance
        .collection(COLLECTION_CHAT_ROOM)
        .doc(chatRoomID)
        .set(chatRoomMap);
  }

  getChatRooms(String userName) async{
    return await FirebaseFirestore.instance
        .collection(COLLECTION_CHAT_ROOM)
        .where(KEY_USERKEYS, arrayContains: userName)
        .snapshots();
  }
}

ChatRoomNetRepositoy chatRoomNetRepositoy = ChatRoomNetRepositoy();
