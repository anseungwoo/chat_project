import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/friend_screen_provider.dart';
import 'package:test_provider/provider/page_provider.dart';
import 'package:test_provider/provider/search_provider.dart';
import 'package:test_provider/screen/bottom_navi_screen.dart';

class MainProvider extends StatefulWidget {
  @override
  _MainProviderState createState() => _MainProviderState();
}

class _MainProviderState extends State<MainProvider> {
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
