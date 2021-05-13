import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/friend_screen_provider.dart';
import 'package:test_provider/screen/add_friend_screen.dart';
import 'package:test_provider/screen/profile_screen.dart';
import 'package:test_provider/screen/search_friend_screen.dart';

class FriendListScreen extends StatefulWidget {
  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FriendScreenProvider>(
      builder: (BuildContext context, friendScreenProvider, Widget child) {
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
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      IconButton(
                          splashRadius: 12,
                          icon: Icon(Icons.search),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchFriendScreen()));
                          }),
                      IconButton(
                          splashRadius: 12,
                          icon: Icon(Icons.person_add_alt_1_rounded),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>AddFriendScreen()));
                          }),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return _myProfile(40);
                        }
                        if (index == 1) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
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
                                Text("친구",style: TextStyle(color: Colors.black26),),
                                Text("10",style: TextStyle(color: Colors.black26),),
                                Spacer(
                                  flex: 1,
                                ),
                                InkWell(
                                    onTap: () {
                                      friendScreenProvider.Onupdown();

                                    },
                                    child: friendScreenProvider.isHide? Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black54,
                                    ):Icon(
                                      Icons.arrow_drop_up,
                                      color: Colors.black54,
                                    )
                                ),
                              ],
                            ),
                          );
                        }
                        return friendScreenProvider.isHide? _myProfile(30):Container();
                      }),
                )
              ],
            ),
          ),
        );
    },
    );
  }

  Widget _myProfile(double radius) {
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
                Text("이름", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("상태메세지"),
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
}