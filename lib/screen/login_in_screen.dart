import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/State/firebase_auth_state.dart';

class LogininScreen extends StatefulWidget {
  const LogininScreen({Key key}) : super(key: key);

  @override
  _LogininScreenState createState() => _LogininScreenState();
}

class _LogininScreenState extends State<LogininScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _eController = TextEditingController();
  final TextEditingController _pController = TextEditingController();


  @override
  void dispose() {
    _eController.dispose();
    _pController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                    "https://www.blockmedia.co.kr/wp-content/uploads/2021/02/%EC%9D%BC%EB%A1%A0%EB%A8%B8%EC%8A%A4%ED%81%AC_%EA%B0%80%EB%A1%9C%EC%A7%81%EC%82%AC%EA%B2%A9%ED%98%95.jpg"),
              ),
              TextFormField(
                cursorColor: Colors.black54,
                controller: _eController,
                decoration: _textInputDecor("Emial"),
                validator: (text) {
                  if (text.isNotEmpty && text.contains("@")) {
                    return null;
                  } else {
                    return "정확한 이메일을 적어주세요";
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                cursorColor: Colors.black54,
                controller: _pController,
                obscureText: true,
                decoration: _textInputDecor("비밀번호"),
                validator: (text) {
                  if (text.isNotEmpty && text.length > 5) {
                    return null;
                  } else {
                    return "정확한 비밀번호를 적어주세요";
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              OutlinedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Provider.of<FireBaseAuthState>(context, listen: false).login(context,
                          email: _eController.text, password: _pController.text);

                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                  ),
                  child: Text(
                    "로그인",
                    style: TextStyle(color: Colors.white),
                  )),


           ],
          ),
        ),
      ),
    );
  }

  InputDecoration _textInputDecor(String hint) {
    return InputDecoration(
      hintText: hint,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[200],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[200],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      fillColor: Colors.grey[200],
      filled: true,
    );
  }
}
