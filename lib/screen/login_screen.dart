import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/login_screen_provider.dart';

import '../main_provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _Gkey = GlobalKey<FormState>();
  final TextEditingController _eController = TextEditingController();
  final TextEditingController _pController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _logo,
              Stack(
                children: <Widget>[
                  _inputForm(size),
                  _inputButton(size),
                ],
              ),
              Consumer<LoginScreenProvider>(
                builder: (context, login, child) => GestureDetector(
                    onTap: () {
                      login.toggle();
                    },
                    child: Text(
                      login.isJoin ? " " : "회원가입",
                      style: TextStyle(
                          color: login.isJoin ? Colors.red : Colors.blue),
                    )),
              ),
              Container(
                height: size.height * 0.05,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _inputForm(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.1),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _Gkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _eController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.account_circle), labelText: "이메일"),
                  validator: (String value) {
                    if (value.isEmpty)
                      return "이메일을 적으세요";
                    else
                      return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: _pController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key), labelText: "비밀번호"),
                  validator: (String value) {
                    if (value.isEmpty)
                      return "비밀번호을 적으세요";
                    else
                      return null;
                  },
                ),
                Container(
                  height: 12,
                ),
                Consumer<LoginScreenProvider>(
                  builder: (context, login, child) => GestureDetector(
                    onTap: () {
                      login.toggle();
                    },
                    child: Text(login.isJoin ? " " : "비밀번호를 잊으셨나요?"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputButton(Size size) {
    return Positioned(
      left: size.width * 0.15,
      right: size.width * 0.15,
      bottom: 0,
      child: Consumer<LoginScreenProvider>(
        builder: (context, login, child) => GestureDetector(
          onTap: () {
            login.toggle();
          },
          child: RaisedButton(
            color: login.isJoin ? Colors.red : Colors.lightBlue,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              if (!login.isJoin) {
                if (_Gkey.currentState.validate()) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainProvider()));
                }
              } else {
                login.toggle();
              }
            },
            child: Text(login.isJoin ? "회원가입" : "로그인"),
          ),
        ),
      ),
    );
  }

  Widget get _logo => Expanded(
    child: Padding(
      padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
      child: FittedBox(
        fit: BoxFit.contain,
        child: CircleAvatar(
          backgroundImage: NetworkImage("https://www.blockmedia.co.kr/wp-content/uploads/2021/02/%EC%9D%BC%EB%A1%A0%EB%A8%B8%EC%8A%A4%ED%81%AC_%EA%B0%80%EB%A1%9C%EC%A7%81%EC%82%AC%EA%B2%A9%ED%98%95.jpg"),
        ),
      ),
    ),
  );
}
