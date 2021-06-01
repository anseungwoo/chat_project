import 'package:flutter/material.dart';
import 'package:local_image_provider/local_album.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/models/user_model_state.dart';
import 'package:test_provider/provider/page_provider.dart';
import 'package:test_provider/screen/chat_room_screen.dart';
import 'package:test_provider/screen/friend_list_screen.dart';
import 'package:test_provider/screen/search_screen.dart';

import 'indicator.dart';

class BottomNaviScreen extends StatefulWidget {

  @override
  _BottomNaviScreenState createState() => _BottomNaviScreenState();
}

class _BottomNaviScreenState extends State<BottomNaviScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer<PageProvider>(
        builder: (BuildContext context, pageProvider, Widget child) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.redAccent,
            unselectedItemColor: Colors.black54,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: pageProvider.pageIndex,
            onTap: (index){
                pageProvider.setPageIndex(index);

            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.account_circle),
                  label : ""),
              BottomNavigationBarItem(icon: Icon(Icons.chat),
                  label : ""),
              BottomNavigationBarItem(icon: Icon(Icons.card_travel),
                  label : ""),

            ],
          );
        },
      ),
      body: Consumer<PageProvider>(
        builder: (BuildContext context, pageProvider, Widget child) {
          return PageView(
            controller: pageProvider.pageController,
            onPageChanged: (index){
              pageProvider.OnPagechaged(index);
            },
            children: [
              FriendListScreen(),
              Consumer<UserModelState>(
                  builder: (BuildContext context, UserModelState userModelState, Widget child) {
                return ChatRoomScreen(userModelState.userModel.email);
              }),

              SearchScreen(),
            ],
          );
        },
      ),
    );
}
}
