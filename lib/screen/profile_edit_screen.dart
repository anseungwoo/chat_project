import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/constant/size.dart';
import 'package:test_provider/models/firebase_auth_state.dart';
import 'package:test_provider/screen/camara_screen.dart';

import 'profile_screen.dart';

class ProfileEditScreen extends StatefulWidget {
  static double _radius = 50;

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final _name = TextEditingController();
  final _commet = TextEditingController();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void dispose() {
    _name.dispose();
    _commet.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://picsum.photos/1000"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CameraScreen()));
                },
              ),
            ),
            Positioned(
              bottom: screenSize(context).width / 1.5,
              right: screenSize(context).width / 2 - ProfileEditScreen._radius,
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://picsum.photos/200"),
                radius: ProfileEditScreen._radius,
              ),
            ),
            Positioned(
              bottom: screenSize(context).width / 1.5,
              right: screenSize(context).width / 2 - ProfileEditScreen._radius,
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CameraScreen()));
                },
              ),
            ),
            SizedBox(
              width: screenSize(context).width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenSize(context).width * 3 / 4,
                    ),
                    TextField(
                      controller: _name,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: '변경할 이름 입력',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: TextField(
                        controller: _commet,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: '변경할 상태메세지 입력',
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Provider.of<FireBaseAuthState>(context, listen: false)
                              .namecommetchang(context, name: _name.text, commet: _commet.text);

                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProfileScreen()));
                        },
                        child: Text(
                          '수정하기',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
