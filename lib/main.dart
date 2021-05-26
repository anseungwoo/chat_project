import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/main_provider.dart';
import 'package:test_provider/models/firebase_auth_state.dart';
import 'package:test_provider/models/user_model_state.dart';
import 'package:test_provider/repos/user_net_repository.dart';
import 'package:test_provider/screen/login_screen.dart';

import 'screen/indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FireBaseAuthState _firebaseAuthState = FireBaseAuthState();
  Widget _currentWidget;
  @override
  Widget build(BuildContext context) {
    _firebaseAuthState.watchAuthChange();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FireBaseAuthState>.value(
            value: _firebaseAuthState),
        ChangeNotifierProvider<UserModelState>(
          create: (_) => UserModelState(),
        ),
      ],
      child: MaterialApp(
        home: Consumer<FireBaseAuthState>(builder: (BuildContext context,
            FireBaseAuthState firebaseAuthState, Widget child) {
          switch (firebaseAuthState.fireBaseAuthStatus) {
            case FirebaseAuthStatus.signout:
              _clearUserModel(context);
              _currentWidget = LoginScreen();
              break;
            case FirebaseAuthStatus.signin:
              _initUserModel(firebaseAuthState, context);
              _currentWidget = MainProvider();
              break;

            default:
              _currentWidget = MyProgressIndicator();
          }

          return AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: _currentWidget,
          );

        }),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),),


    );

  }

  void _initUserModel(
      FireBaseAuthState firebaseAuthState, BuildContext context) {
    UserModelState userModelState =
    Provider.of<UserModelState>(context, listen: false);

    if (userModelState.currentStreamSub == null) {
      userModelState.currentStreamSub = userNetRepository
          .getUserModelStream(firebaseAuthState.user.uid)
          .listen((userModel) {
        userModelState.userModel = userModel;

        print('userModel: ${userModel.username} , ${userModel.userKey}');
      });
    }
  }

  void _clearUserModel(BuildContext context) {
    UserModelState userModelState =
    Provider.of<UserModelState>(context, listen: false);
    userModelState.clear();
  }
}
