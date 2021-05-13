import 'package:flutter/cupertino.dart';

class FriendScreenProvider extends ChangeNotifier{
  bool _isHide;
  FriendScreenProvider(){
    this._isHide=true;
  }

  get isHide => _isHide;

  void Onupdown(){
    _isHide = ! isHide;

    notifyListeners();
  }



}