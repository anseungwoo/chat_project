import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/main_provider.dart';

import 'provider/login_screen_provider.dart';
import 'screen/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) {
              return LoginScreenProvider();
            },
          )
        ],
        child: LoginScreen(),
      ),
    );
  }
}
