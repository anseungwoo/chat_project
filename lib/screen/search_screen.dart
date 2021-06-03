import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/State/firebase_auth_state.dart';
import 'package:test_provider/provider/search_provider.dart';
import 'package:test_provider/repos/search_net_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController myController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Consumer<SearchPovider>(
      builder: (BuildContext context, searchProvider, Widget child)
    {
      return Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "검색",
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Text('내가아는 숨은 맛집추가하기'),
                    InkWell(
                        onTap: () {
                          launch("http://naver.me/GxOaiZcv");
                        },
                        child: Icon(Icons.add_circle)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: myController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(
                                left: 15,
                                bottom: 11,
                                top: 11,
                                right: 15),
                            hintText: "지역명을 입력해주세요."),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          searchNetRepositoy.searchStream(myController.text);
                          searchProvider.setMessage();
                        },
                        splashColor: Colors.black38,
                        child: Icon(Icons.arrow_forward)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {

                    return Text("gfd");
                  },
                  separatorBuilder:
                      (BuildContext context, int index) =>
                  const Divider(),
                ),
              ),
              InkWell(
                  onTap: () {
                    Provider.of<FireBaseAuthState>(context,
                        listen: false)
                        .signOut();
                  },
                  child: Text('Sign out')),
            ],
          ),
        ),
      );
    });
  }
}
