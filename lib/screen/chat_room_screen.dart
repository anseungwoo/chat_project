import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_provider/constant/size.dart';
import 'package:test_provider/screen/add_chat_room_screen.dart';

import 'chating_room_friend_list_screen.dart';
import 'search_chatingroom_screen.dart';

class ChatRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "채팅",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  // IconButton(
                  //     splashRadius: 12,
                  //     icon: Icon(Icons.search),
                  //     onPressed: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (_) => SearchChtingroomScreen()));
                  //     }),
                  IconButton(
                      splashRadius: 12,
                      icon: Icon(Icons.add_comment_outlined),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => AddChatRoomScreen()));
                      }),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        splashColor: Colors.black38,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      ChatingRoomFriendListScreen()));
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage("https://picsum.photos/200"),
                                radius: 30,
                              ),
                            ),
                            SizedBox(
                              width: screenSize(context).width / 30,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "채팅방이름",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "7",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "채팅방내용dsadasdasdasdasdasdasdasdasdasdas",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "채팅방시간",
                                  style: TextStyle(color: Colors.black38),
                                ),

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
      ),
    );
  }
}
