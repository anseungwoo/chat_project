import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/models/firebase_auth_state.dart';
import 'package:test_provider/models/user_net_repository.dart';
import 'package:test_provider/provider/search_provider.dart';

class SearchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchPovider>(
      builder: (BuildContext context, searchProvider, Widget child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
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
                        onTap: (){
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
                          controller: searchProvider.messageContorller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: "Hint here"),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            searchProvider.setMessage();
                          },
                          splashColor: Colors.black38,
                          child: Icon(Icons.arrow_forward)),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: searchProvider.messages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              onTap: () {},
                              child: Text("${searchProvider.messages[index]}"" 검색에 대한 결과입니다"));
                        }),
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
}
