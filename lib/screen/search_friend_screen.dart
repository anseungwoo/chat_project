import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

import 'profile_screen.dart';

class SearchFriendScreen extends StatefulWidget {
  @override
  _SearchFriendScreenState createState() => _SearchFriendScreenState();
}

class _SearchFriendScreenState extends State<SearchFriendScreen> {
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('친구검색하기'),
        actions: [searchBar.getSearchAction(context)]);
  }
  void onSubmitted(String value) {
    setState(() => _scaffoldKey.currentState
        .showSnackBar(SnackBar(content:  Text('You wrote $value!'))));
  }
  _SearchFriendScreenState() {
    searchBar = SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print("cleared");
        },
        onClosed: () {
          print("closed");
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfileScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("친구"),
              Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      CircleAvatar(
                      backgroundImage: NetworkImage("https://picsum.photos/200"),
                      radius: 20,
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
                  );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
