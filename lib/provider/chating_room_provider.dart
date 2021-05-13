import 'package:flutter/cupertino.dart';

class ChatingRoomProvider extends ChangeNotifier{
  TextEditingController _messageContorller;
  List<String> _messages;

  ChatingRoomProvider(){
    this._messages=[];
    this._messageContorller = TextEditingController();
  }

  get messages => _messages;
  get messageContorller => _messageContorller;

  void setMessage(){
      if(_messageContorller.text.isNotEmpty){
          _messages.insert(0, _messageContorller.text);
          _messageContorller.clear();
          print(_messages);
          notifyListeners();
    }
  }
}