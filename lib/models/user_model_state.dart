import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:test_provider/models/user_model.dart';

class UserModelState extends ChangeNotifier{
  UserModel _userModel;
  StreamSubscription<UserModel> _currentStreamSub;
  UserModel get userModel => _userModel;
  StreamSubscription<UserModel> get currentStreamSub => _currentStreamSub;

  set userModel(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  set currentStreamSub(StreamSubscription<UserModel> currentStreamSub) =>
      _currentStreamSub = currentStreamSub;

  clear() async {
    if (_currentStreamSub != null) await _currentStreamSub.cancel();
    _currentStreamSub = null;
    _userModel = null;
  }


}