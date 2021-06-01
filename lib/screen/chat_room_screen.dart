import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_provider/constant/size.dart';
import 'package:test_provider/models/user_model.dart';
import 'package:test_provider/repos/chatroom_net_repositoy.dart';
import 'package:test_provider/screen/indicator.dart';

import 'chating_room_screen.dart';

class ChatRoomScreen extends StatefulWidget {
  final String emial;

  const ChatRoomScreen(this.emial, {Key key}) : super(key: key);

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  Stream chatRoomsStream;
  String userEmail;
  String roomID;

  void initState() {
    getUserInfogetChats();
    super.initState();
  }

  getUserInfogetChats() async {
    chatRoomNetRepositoy.getChatRooms(widget.emial).then((snapshots) async {
      setState(() {
        chatRoomsStream = snapshots;
        print(
            "we got the data + ${chatRoomsStream.toString()} this is name  ${widget.emial}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              resizeToAvoidBottomInset : true,
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
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
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
                          // IconButton(
                          //     splashRadius: 12,
                          //     icon: Icon(Icons.add_comment_outlined),
                          //     onPressed: () {
                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (_) => AddChatRoomScreen()));
                          //     }),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              userEmail = snapshot.data.docs[index]
                                  .data()["room_name"]
                                  .toString()
                                  .replaceAll("_", "")
                                  .replaceAll(widget.emial, "");
                              roomID = snapshot.data.docs[index]
                                  .data()["room_name"]
                                  .toString();

                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChatingRoomScreen(roomID,
                                                  snapshot.data.docs[index]
                                                      .data()["room_name"]
                                                      .toString()
                                                      .replaceAll("_", "")
                                                      .replaceAll(widget.emial, ""), widget.emial)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Text(userEmail.substring(0, 1),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: 'OverpassRegular',
                                                fontWeight: FontWeight.w300)),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  userEmail,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(
                                        flex: 1,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "채티방들어가기",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return MyProgressIndicator();
          }
        });
  }
}
