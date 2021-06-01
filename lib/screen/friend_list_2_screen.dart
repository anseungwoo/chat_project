import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/models/user_model.dart';
import 'package:test_provider/models/user_model_state.dart';
import 'package:test_provider/provider/friend_screen_provider.dart';
import 'package:test_provider/repos/user_net_repository.dart';
import 'package:test_provider/screen/add_friend_screen.dart';
import 'package:test_provider/screen/profile_screen.dart';
import 'indicator.dart';



class FriendList2Screen extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    return Consumer<FriendScreenProvider>(
        builder: (BuildContext context, friendScreenProvider, Widget child) {
          return Consumer<UserModelState> (
              builder: (BuildContext context, UserModelState userModelState, Widget child) {
                if (userModelState == null ||
                    userModelState.userModel == null ||
                    userModelState.userModel.friend == null ||
                    userModelState.userModel.friend.isEmpty)
                  return MyProgressIndicator();
                else{
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
                                    fontSize: 22, fontWeight: FontWeight.bold),
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
                                  icon: Icon(Icons.person_add_alt_1_rounded),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (_) => AddFriendScreen()));
                                  }),
                            ],
                          ),
                        ),
                        StreamProvider<List<UserModel>>.value(
                          value: userNetRepository.getUser(userModelState.userModel.friend),
                          child: Consumer<List<UserModel>>(
                              builder: (BuildContext context, List<UserModel> posts, Widget child) {
                                if (posts == null || posts.isEmpty)
                                  return MyProgressIndicator();
                                else {
                                  print(posts);
                                  return Expanded(
                                    child: ListView.builder(
                                        itemCount: posts.length,
                                        itemBuilder: (context, index) =>
                                            _Profile(
                                                context, 30, posts[index])),
                                  );
                                }
                              }
                              )
                        )



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


Widget _Profile(BuildContext context,double radius,UserModel userModel) {

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) =>
                            ProfileScreen()));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://picsum.photos/200"),
                        radius: radius,
                      ),
                      Spacer(
                        flex: 6,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userModel.username),
                          Text(userModel.message),
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

