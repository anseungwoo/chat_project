import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/constant/size.dart';
import 'package:test_provider/models/user_model_state.dart';
import 'package:test_provider/repos/chatroom_net_repositoy.dart';
import 'package:test_provider/screen/profile_edit_screen.dart';
import 'chating_room_screen.dart';

class ProfileScreen extends StatefulWidget {


  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  double _radius = 50;

  @override

  Widget build(BuildContext context) {

    UserModelState userModelState = Provider.of<UserModelState>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(userModelState.userModel.backImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
              bottom: screenSize(context).width / 1.2,
              right: screenSize(context).width / 2 - _radius,
              child: CircleAvatar(
                backgroundImage: NetworkImage(userModelState.userModel.profileImg),
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
                    userModelState == null || userModelState.userModel == null
                        ? ""
                        : userModelState.userModel.username,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),

                  Center(
                    child: Text(
                      userModelState == null || userModelState.userModel == null
                          ? ""
                          : userModelState.userModel.message,
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
                            onTap: () {
                              createChatRoom(context,userModelState.userModel.email,userModelState.userModel.email);
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
                            width: screenSize(context).width / 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ProfileEditScreen()));
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                Text(
                                  "내프로필수정하기",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
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
