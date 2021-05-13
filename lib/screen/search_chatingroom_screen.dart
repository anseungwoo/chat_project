import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:test_provider/constant/size.dart';

import 'chating_room_screen.dart';

class SearchChtingroomScreen extends StatefulWidget {
  @override
  _SearchChtingroomScreenState createState() => _SearchChtingroomScreenState();
}

class _SearchChtingroomScreenState extends State<SearchChtingroomScreen> {
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('채팅방검색하기'),
        actions: [searchBar.getSearchAction(context)]);
  }
  void onSubmitted(String value) {
    setState(() => _scaffoldKey.currentState
        .showSnackBar(SnackBar(content:  Text('You wrote $value!'))));
  }
  _SearchChtingroomScreenState() {
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
      body:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("채팅방"),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index){
                    return InkWell(
                      splashColor: Colors.black38,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>ChatingRoomScreen()));},
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage("https://picsum.photos/200"),
                              radius: 30,
                            ),
                          ),
                          SizedBox(width: screenSize(context).width/30,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("채팅방이름",maxLines:1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                    Text("7",style: TextStyle(fontSize: 12,),),
                                  ],
                                ),
                                Text("채팅방내용dsadasdasdasdasdasdasdasdasdasdas",maxLines:2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12,),),

                              ],
                            ),
                          ),
                          Spacer(flex: 1,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("채팅방시간",style: TextStyle(color: Colors.black38),),
                              CircleAvatar(
                                  radius: 13,
                                  backgroundColor: Colors.red,
                                  child: Text("350",style: TextStyle(fontSize: 12,color: Colors.white),)),

                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
