import 'package:flutter/material.dart';

import 'login_in_screen.dart';
import 'login_up_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget loginupscreen=LoginUpScreen();
  Widget logininscreen=LogininScreen();
  
  Widget currentWidget;
  @override
  void initState(){
    if(currentWidget == null){
      currentWidget =LoginUpScreen();
      super.initState();
    }
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: Duration(microseconds: 300),
              child: currentWidget,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.white,
                child: InkWell(
                  onTap: (){
                    setState(() {
                      if(currentWidget is LoginUpScreen){
                        currentWidget =logininscreen;
                      }
                      else{
                        currentWidget =loginupscreen;
                      }
                    });
                  },
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: (currentWidget is LoginUpScreen)?"로그인화면인로":"회원가입화면으로",
                        style: TextStyle(color: Colors.grey),

                      ),
                    ),
                  ),
                ),

              ),
            ),


          ],
        ),
      ),
    );
  }
}

