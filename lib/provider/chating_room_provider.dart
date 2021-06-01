// import 'package:flutter/cupertino.dart';
// import 'package:test_provider/repos/chat_net_repositoy.dart';
//
// class ChatingRoomProvider extends ChangeNotifier{
//   TextEditingController _messageContorller;
//   List<String> _messages;
//   String _otherUser;
//
//   ChatingRoomProvider(){
//     this._messages=[];
//     this._messageContorller = TextEditingController();
//     this._otherUser ="";
//   }
//   get otherUser => _otherUser;
//   get messages => _messages;
//   get messageContorller => _messageContorller;
//
//   void setMessage(){
//       if(_messageContorller.text.isNotEmpty){
//           _messages.insert(0, _messageContorller.text);
//           _messageContorller.clear();
//           print(_messages);
//           notifyListeners();
//     }
//   }
//   sendMessage() {
//     if (_messageContorller.text.isNotEmpty) {
//       Map<String, String> messageMap = {
//         "message": _messageContorller.text,
//         "sendBy": otherUser,
//       };
//       chatNetRepositoy.getConversationMessages(chatRoomId, messageMap);
//     }
// }