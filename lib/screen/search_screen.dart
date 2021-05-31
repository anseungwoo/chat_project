import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/models/firebase_auth_state.dart';
import 'package:test_provider/provider/search_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String city = " ";
  Map copyText;
  final List<String> entries = <String>['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  TextEditingController myController = TextEditingController();
  void fetchData(String ci){
    setState(() {
      city = ci;
    });
  }
  @override
  Widget build(BuildContext context) {
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
                                  left: 15, bottom: 11, top: 11, right: 15),
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
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: entries.length,
                    itemBuilder: (BuildContext context, int index){
                      return _build(context, city, index);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                  ),
                ),
                InkWell(
                    onTap: () {
                      Provider.of<FireBaseAuthState>(context, listen: false)
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

  Widget _build(BuildContext context, String city, int index){
    CollectionReference st = FirebaseFirestore.instance.collection('store');
    return FutureBuilder<DocumentSnapshot>(
      future: st.doc(city).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text(" ");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map data = snapshot.data.data();
          return Text(data['${entries[index]}'].toString(), style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22),);
        }
        return Text("loading");
      },
    );
  }

}
