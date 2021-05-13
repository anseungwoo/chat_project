import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_provider/constant/size.dart';

import 'profile_screen.dart';

class ProfileEditScreen extends StatelessWidget {
  static double _radius = 50;

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
              child: Icon(Icons.camera_alt),
            ),

            Positioned(
              bottom: screenSize(context).width / 1.5,
              right: screenSize(context).width / 2 - _radius,
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://picsum.photos/200"),
                radius: _radius,
              ),
            ),
            Positioned(
                bottom: screenSize(context).width / 1.5,
                right: screenSize(context).width / 2 - _radius,
                child: Icon(Icons.camera_alt,color: Colors.white,)),
            SizedBox(

              width: screenSize(context).width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenSize(context).width * 3 / 4,
                    ),
                    TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: '변경할 이름 입력',
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: TextField(
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
                      onTap: (){Navigator.pop(context,MaterialPageRoute(builder: (_)=> ProfileScreen()));},
                        child: Text("수정하기",style: TextStyle(fontSize: 30,color: Colors.white),)),
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
