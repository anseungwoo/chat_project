import 'package:flutter/cupertino.dart';


class SearchPovider extends ChangeNotifier{
  TextEditingController _searchmessageContorller;
  List<String> _messages;
  List<dynamic> _chart;

  SearchPovider(){
    this._messages = [];
    this._chart=[{"양산":["진호","승우"],"부산":["성재","동의대"]}];
    this._searchmessageContorller = TextEditingController();
  }

  get messages => _messages;
  get messageContorller => _searchmessageContorller;

  void setMessage(){
    if(_searchmessageContorller.text.isNotEmpty){
      _messages.clear();
      _messages.insert(0,_searchmessageContorller.text);
      _searchmessageContorller.clear();
      print(_messages);
      notifyListeners();
    }
  }

}