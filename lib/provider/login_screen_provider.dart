import 'package:flutter/cupertino.dart';

class LoginScreenProvider extends ChangeNotifier{
  bool _isJoin = false;

  bool get isJoin => _isJoin;
  void toggle(){
    _isJoin = !_isJoin;
    notifyListeners();
  }
}