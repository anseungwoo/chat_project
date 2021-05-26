import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/models/PostModel.dart';
import 'package:test_provider/models/user_model.dart';
import 'package:test_provider/models/user_model_state.dart';
import 'package:test_provider/repos/user_net_repository.dart';
import 'package:test_provider/provider/friend_screen_provider.dart';
import 'package:test_provider/screen/add_friend_screen.dart';
import 'package:test_provider/screen/indicator.dart';
import 'package:test_provider/screen/profile_screen.dart';
import 'package:test_provider/screen/search_friend_screen.dart';



class FriendListScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Consumer<FriendScreenProvider>(
        builder: (BuildContext context, friendScreenProvider, Widget child) {
          return
            Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            '친구',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          IconButton(
                              splashRadius: 12,
                              icon: Icon(Icons.search),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (_) => SearchFriendScreen()));
                              }),
                          IconButton(
                              splashRadius: 12,
                              icon: Icon(Icons.person_add_alt_1_rounded),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (_) => AddFriendScreen()));
                              }),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return _myProfile(context, 40);
                            }
                            if (index == 1) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12),
                                child: Divider(
                                  color: Colors.black54,
                                ),
                              );
                            }
                            if (index == 2) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Text("친구", style: TextStyle(
                                        color: Colors.black26),),
                                    Text('4', style: TextStyle(
                                        color: Colors.black26),),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          friendScreenProvider.Onupdown();
                                        },
                                        child: friendScreenProvider.isHide
                                            ? Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black54,
                                        )
                                            : Icon(
                                          Icons.arrow_drop_up,
                                          color: Colors.black54,
                                        )
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Container(height: 0,);
                          }),
                    ),
                    Expanded(

                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return friendScreenProvider.isHide ? _Profile(
                                context, 30, index) : Container();
                          }),
                    )
                  ],
                ),
              ),
            );
        }

    );
  }

}

  Widget _myProfile(BuildContext context,double radius) {
    UserModelState userModelState = Provider.of<UserModelState>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfileScreen()));},
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage("https://picsum.photos/200"),
              radius: radius,
            ),
            Spacer(
              flex: 6,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userModelState == null || userModelState.userModel==null?"":
                userModelState.userModel.username,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(userModelState == null || userModelState.userModel==null?"":
                userModelState.userModel.message,),
              ],
            ),
            Spacer(
              flex: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _Profile(BuildContext context,double radius,int index) {
    UserModelState userModelState = Provider.of<UserModelState>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfileScreen()));},
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage("https://picsum.photos/200"),
              radius: radius,
            ),
            Spacer(
              flex: 6,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userModelState == null || userModelState.userModel==null?"":
                userModelState.userModel.username,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(userModelState == null || userModelState.userModel==null?"":
                userModelState.userModel.message,),
              ],
            ),
            Spacer(
              flex: 100,
            ),
          ],
        ),
      ),
    );
  }

