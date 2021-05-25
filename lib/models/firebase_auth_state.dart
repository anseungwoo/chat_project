import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_provider/models/user_net_repository.dart';

class FireBaseAuthState extends ChangeNotifier {
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User _firebaseUser;


  void watchAuthChange() {
    _firebaseAuth.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null && _firebaseUser == null) {
        changeFirebaseAuthStatus();
        return;
      } else if (firebaseUser != _firebaseUser) {
        _firebaseUser = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }
  void namecommetchang(BuildContext context,
      {@required String name, @required String commet})async{
    await userNetRepository.namecommet(
        userKey: _firebaseUser.uid, name: name,commet: commet);
  }



  void registerUser(BuildContext context,
      {@required String email, @required String password}) async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    UserCredential authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error);
      String _message = "";
      switch (error.code) {
        case 'ERROR_WEAK_PASSWORD':
          _message = "패스워드를 잘못입력했습니다";
          break;
        case 'ERROR_INVALID_EMAIL':
          _message = "이메일 주소를 잘못입력했습니다";
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          _message = "일론머스크가 사용중입니다.";
          break;
      }

      SnackBar snackBar = SnackBar(
        content: Text(_message),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    });

    _firebaseUser = authResult.user;
    if (_firebaseUser == null) {
      SnackBar snackBar = SnackBar(
        content: Text("Please try again later!"),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      await userNetRepository.attemptCreateUser(
          userKey: _firebaseUser.uid, email: _firebaseUser.email,messeage: "나의상태메세지작성해주세요",name: "");
    }
  }

  void login(BuildContext context,
      {@required String email, @required String password}) async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    UserCredential authResult = await _firebaseAuth
        .signInWithEmailAndPassword(
        email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error);
      String _message = "";
      switch (error.code) {
        case 'ERROR_INVALID_EMAIL':
          _message = "이메일주소를 잘못입력했습니다";
          break;
        case 'ERROR_WRONG_PASSWORD':
          _message = "비밀번호가 틀립니다.";
          break;
        case 'ERROR_USER_NOT_FOUND':
          _message = "당신은 일론머스크입니다(유저없음)";
          break;
        case 'ERROR_USER_DISABLED':
          _message = "당신은 일론머스크거짓말에현혹되었습니다.(유저금지)";
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          _message = "많은시도가 있습니다. 나중에 다시시도하세요";
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          _message = "일론머스크에게 틀켰습니다.(사용금지)";
          break;
      }

      SnackBar snackBar = SnackBar(
        content: Text(_message),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    });

    _firebaseUser = authResult.user;
    if (_firebaseUser == null) {
      SnackBar snackBar = SnackBar(
        content: Text("Please try again later!"),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
  void signOut() async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if (_firebaseUser != null) {
      _firebaseUser = null;
      await _firebaseAuth.signOut();
    }
    notifyListeners();
  }



  void changeFirebaseAuthStatus([FirebaseAuthStatus firebaseAuthStatus]) {
    if (firebaseAuthStatus != null) {
      _firebaseAuthStatus = firebaseAuthStatus;
    } else {
      if (_firebaseUser != null) {
        _firebaseAuthStatus = FirebaseAuthStatus.signin;
      } else {
        _firebaseAuthStatus = FirebaseAuthStatus.signout;
      }
    }

    notifyListeners();
  }

  FirebaseAuthStatus get fireBaseAuthStatus => _firebaseAuthStatus;
  User get user =>_firebaseUser;
}

enum FirebaseAuthStatus { signout, progress, signin }
