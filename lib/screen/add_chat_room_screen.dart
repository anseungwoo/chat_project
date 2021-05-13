import 'package:flutter/material.dart';

class AddChatRoomScreen extends StatefulWidget {
  @override
  _AddChatRoomScreenState createState() => _AddChatRoomScreenState();
}

class _AddChatRoomScreenState extends State<AddChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AddChatRoomScreen()));
                      }),
                  Text(
                    "대화상대 선택",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.search_rounded),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "이름 검색"),
                      ),
                    ),
                    InkWell(
                        onTap: () {},
                        splashColor: Colors.black38,
                        child: Icon(Icons.arrow_forward)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "친구 658",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage("https://picsum.photos/200"),
                              radius: 20,
                            ),
                            Spacer(
                              flex: 6,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("이름",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
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
