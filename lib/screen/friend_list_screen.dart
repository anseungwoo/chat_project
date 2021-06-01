import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/constant/imafe_helper.dart';
import 'package:test_provider/models/user_model.dart';
import 'package:test_provider/models/user_model_state.dart';
import 'package:test_provider/provider/friend_screen_provider.dart';
import 'package:test_provider/repos/user_net_repository.dart';
import 'package:test_provider/screen/add_friend_screen.dart';
import 'package:test_provider/screen/profile_screen.dart';
import 'indicator.dart';
import 'progile_friend_screen.dart';



class FriendListScreen extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return Consumer<FriendScreenProvider>(
        builder: (BuildContext context, friendScreenProvider, Widget child) {
          return Consumer<UserModelState> (
                builder: (BuildContext context, UserModelState userModelState, Widget child) {
                  if (userModelState == null ||
                      userModelState.userModel == null ||
                      userModelState.userModel.myfriendcount == null
                     )
                    return MyProgressIndicator();
                  else {
                    return Scaffold(
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
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  // IconButton(
                                  //     splashRadius: 12,
                                  //     icon: Icon(Icons.search),
                                  //     onPressed: () {
                                  //       Navigator.push(context, MaterialPageRoute(
                                  //           builder: (_) => SearchFriendScreen()));
                                  //     }),
                                  IconButton(
                                      splashRadius: 12,
                                      icon: Icon(
                                          Icons.person_add_alt_1_rounded),
                                      onPressed: () {
                                        Navigator.push(
                                            context, MaterialPageRoute(
                                            builder: (_) => AddFriendScreen()));
                                      }),
                                ],
                              ),
                            ),

                            Expanded(
                              child: ListView.builder(
                                  itemCount: userModelState.userModel
                                      .myfriendcount + 3,
                                  itemBuilder: (BuildContext context,
                                      int index) {
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
                                            Text("${userModelState.userModel
                                                .myfriendcount}",
                                              style: TextStyle(
                                                  color: Colors.black26),),
                                            Spacer(
                                              flex: 1,
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  friendScreenProvider
                                                      .Onupdown();
                                                },
                                                child: friendScreenProvider
                                                    .isHide
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
                                    return friendScreenProvider.isHide
                                        ? _Profile(
                                        context, 30, index)
                                        : Container();
                                  }),
                            ),

                          ],
                        ),
                      ),
                    );
                  }
                }
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
              backgroundImage: NetworkImage(userModelState.userModel.profileImg),
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
    List<dynamic> followings;

    return Consumer(
      builder: (BuildContext context, UserModelState mUserModelState, Widget child) {
        followings=mUserModelState.userModel.friend;
        return StreamBuilder<List<UserModel>>(
            stream: userNetRepository.getAllUser(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                UserModel otherUser = snapshot.data[index-3];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                ProfileFriendScreen(otherUser)));
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:NetworkImage(
                                otherUser.profileImg),
                            radius: radius,
                          ),
                          Spacer(
                            flex: 6,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(otherUser.username),
                              Text(otherUser.message),
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
              else
              {
                return MyProgressIndicator();
              }
            }
        );
      },

    );
  }

