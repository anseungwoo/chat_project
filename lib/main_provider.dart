import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/friend_screen_provider.dart';
import 'package:test_provider/provider/page_provider.dart';
import 'package:test_provider/provider/search_provider.dart';
import 'package:test_provider/screen/bottom_navi_screen.dart';

class MainProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return PageProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return FriendScreenProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return SearchPovider();
          },
        )
      ],
      child: BottomNaviScreen(),
    );
  }
}
