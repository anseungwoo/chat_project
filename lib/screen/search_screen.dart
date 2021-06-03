import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/provider/search_provider.dart';
import 'package:test_provider/repos/search_net_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import '../State/firebase_auth_state.dart';
import '../repos/chatroom_net_repositoy.dart';
import 'indicator.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String city = " ";
  Future _future;
  int abc = 0;
  Map copyText;
  final List<String> entries = <String>['0', '1', '2', '3', '4', '5', '6', '7'];
  TextEditingController myController = TextEditingController();
  void fetchData(String ci){
    if(ci.isEmpty) ci = "1";
    setState(() {
      city = ci;
    });
  }
  @override
  Widget build(BuildContext context) {
    CollectionReference st = FirebaseFirestore.instance.collection("store");
    _future = st.doc(city).get();
    return Consumer<SearchPovider>(
      builder: (BuildContext context, searchProvider, Widget child) {
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
                            fetchData(myController.text);
                            searchProvider.setMessage();
                          },
                          splashColor: Colors.black38,
                          child: Icon(Icons.arrow_forward)),
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder<DocumentSnapshot>(
                      future: st.doc(city).get(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: entries.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (snapshot.hasError) {
                              return Text("Something went wrong");
                            }
                            if (snapshot.hasData && !snapshot.data.exists) {
                              return Text(" ");
                            }
                            if (snapshot.connectionState == ConnectionState.done) {
                              Map data = snapshot.data.data();
                              if(data['${entries[index]}'].toString() == "null") {
                                return Container();
                              }
                              else{
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    data['${entries[index]}'].toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 22),),
                                );
                              }
                            }
                            return Text("loading");
                          },
                        );
                      }
                  ),
                ),
                InkWell(
                    onTap: () {
                      Provider.of<FireBaseAuthState>(
                          context, listen: false)
                          .signOut();
                    },
                    child: Text('Sign out')),
              ],
            ),
          ),
        );
      },
    );

  }
}
