
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/constant/size.dart';
import 'package:test_provider/models/post_model.dart';
import 'package:test_provider/State/firebase_auth_state.dart';
import 'package:test_provider/State/user_model_state.dart';
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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void dispose() {
    _name.dispose();
    _commet.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModelState userModelState = Provider.of<UserModelState>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          key: _formKey,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(userModelState.userModel.backImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  _openCamera(context);
                },
              ),
            ),
            Positioned(
              bottom: screenSize(context).width/1.2 ,
              right: screenSize(context).width / 2 - ProfileEditScreen._radius,
              child: CircleAvatar(
                backgroundImage: NetworkImage(userModelState.userModel.profileImg),
                radius: ProfileEditScreen._radius,
              ),
            ),
            Positioned(
              bottom: screenSize(context).width /1.2 ,
              right: screenSize(context).width / 2 - ProfileEditScreen._radius,
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                onPressed: () {
                  _openCamera(context);
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
                    TextFormField(
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
                      child: TextFormField(
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
                            if(_name.text.isEmpty&& _commet.text.isNotEmpty){
                              Provider.of<FireBaseAuthState>(context, listen: false)
                                  .namecommetchang(context, name: userModelState.userModel.username, commet: _commet.text);

                              Navigator.pop(
                                  context,);

                            }
                            if(_commet.text.isEmpty&& _name.text.isNotEmpty){
                              Provider.of<FireBaseAuthState>(context, listen: false)
                                  .namecommetchang(context, name: _name.text, commet: userModelState.userModel.message);

                              Navigator.pop(
                                context,);

                          }
                          if(_commet.text.isNotEmpty&& _name.text.isNotEmpty){

                          Provider.of<FireBaseAuthState>(context, listen: false)
                              .namecommetchang(context, name: _name.text, commet: _commet.text);

                          Navigator.pop(
                            context,);
                          }
                            if(_commet.text.isEmpty&& _name.text.isEmpty){

                              Provider.of<FireBaseAuthState>(context, listen: false)
                                  .namecommetchang(context, name: userModelState.userModel.username, commet: userModelState.userModel.message);

                              Navigator.pop(
                                context,);
                            }


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

  void _openCamera(context) async {
    if (await checkIfPermissionGranted(context))
      Navigator
          .push(context,MaterialPageRoute(builder: (_) => CameraScreen()));
    else {
      Navigator
          .push(context,MaterialPageRoute(builder: (_) => CameraScreen()));
      SnackBar snackBar = SnackBar(
        content: Text('사진, 파일, 마이크 접근 허용 해주셔야 카메라 사용 가능합니당!!'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            _key.currentState.hideCurrentSnackBar();
            AppSettings.openAppSettings();
          },
        ),
      );
      _key.currentState.showSnackBar(snackBar);
    }
  }
  Future<bool> checkIfPermissionGranted(BuildContext context) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Platform.isIOS ? Permission.photos : Permission.storage
    ].request();
    bool permitted = true;

    statuses.forEach((permission, permissionStatus) {
      if (!permissionStatus.isGranted) permitted = false;
    });

    return permitted;
  }
}
