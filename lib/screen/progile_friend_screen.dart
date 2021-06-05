import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/constant/size.dart';
import 'package:test_provider/models/user_model.dart';
import 'package:test_provider/State/user_model_state.dart';
import 'package:test_provider/repos/chatroom_net_repositoy.dart';

import 'chating_room_screen.dart';


class ProfileFriendScreen extends StatelessWidget {
  final UserModel usermodel;
  final String Memail;
  double _radius = 50;

  ProfileFriendScreen(this.usermodel,{Key key,@required this.Memail}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(usermodel.backImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
                bottom: screenSize(context).width / 1.2,
                right: screenSize(context).width / 2 - _radius,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(usermodel.profileImg),
                  radius: _radius,
                )
            ),

            SizedBox(
              width: screenSize(context).width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenSize(context).width * 3 / 5,
                  ),
                  Text(
                   usermodel.username,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),

                  Center(
                    child: Text(
                      usermodel.message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
                bottom: 0,
                child: SizedBox(
                  width: screenSize(context).width,
                  child: Column(
                    children: [
                      Divider(
                        thickness: 3,
                        height: 3,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: screenSize(context).width / 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              createChatRoom(context,usermodel.email,Memail);
                            },
                            child: Column(
                              children: [
                                Icon(Icons.chat, color: Colors.white),
                                Text("1:1채팅하기",
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenSize(context).width/100,
                          ),

                        ],
                      ),
                      SizedBox(
                        height: screenSize(context).width / 18,
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
  createChatRoom(BuildContext context,String userEmail,String myemail){
    List<String> user= [userEmail,myemail];
   String RoomId= getChatRoomId(userEmail,myemail);
    Map<String,dynamic> charRoom ={
      "userkeys": user,
      "room_name":RoomId,
    };
    chatRoomNetRepositoy.createChatRoom(chatRoomID: RoomId,chatRoomMap:charRoom);
    Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatingRoomScreen(RoomId,userEmail,myemail)));
  }
  getChatRoomId(String a,String b){
    if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
      return "$a\_$b";
    }
    else{
      return "$b\_$a";
    }
  }
}
