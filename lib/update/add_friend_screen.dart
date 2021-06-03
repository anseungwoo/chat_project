import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/models/user_model.dart';
import 'package:test_provider/models/user_model_state.dart';
import 'package:test_provider/repos/user_net_repository.dart';
import 'package:test_provider/screen/indicator.dart';

class AddFriendScreen extends StatefulWidget {
  @override
  _AddFriendScreenState createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final count = 0;
  final _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserModel>>(
        stream: userNetRepository.getAllUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "친구 추가",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "ID 추가",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                        color: Colors.black54,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Consumer<UserModelState>(
                          builder: (BuildContext context,
                              UserModelState mUserModelState, Widget child) {
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                UserModel otherUser = snapshot.data[index];
                                bool fcount = mUserModelState
                                    .friendcount(otherUser.userKey);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("유저이름: "+otherUser.username),
                                          Text("유저 이메일: "+otherUser.email),
                                        ],
                                      ),
                                      Spacer(
                                        flex: 1,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          fcount
                                              ? userNetRepository.unaddUser(
                                                  myUserKey: mUserModelState
                                                      .userModel.userKey,
                                                  otherUserKey:
                                                      otherUser.userKey)
                                              : userNetRepository.addUser(
                                                  myUserKey: mUserModelState
                                                      .userModel.userKey,
                                                  otherUserKey:
                                                      otherUser.userKey);
                                          fcount
                                              ? userNetRepository.unaddCUser(
                                                  myUserKey: mUserModelState
                                                      .userModel.userKey,
                                                  otherUserKey:
                                                      otherUser.userKey)
                                              : userNetRepository.addCUser(
                                                  myUserKey: mUserModelState
                                                      .userModel.userKey,
                                                  otherUserKey:
                                                      otherUser.userKey);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 100,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: fcount
                                                ? Colors.green
                                                : Colors.red,
                                            border: Border.all(
                                                color: fcount
                                                    ? Colors.green
                                                    : Colors.red,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            fcount ? "이미친구입니다" : "친구추가하기",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return MyProgressIndicator();
          }
        });
  }
}
