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
              backgroundColor: Color.fromRGBO(255, 192, 203, 1.0),
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
                                              ChatingRoomScreen(snapshot.data.docs[index]
                                                  .data()["room_name"]
                                                  .toString(),
                                                  snapshot.data.docs[index]
                                                      .data()["room_name"]
                                                      .toString()
                                                      .replaceAll("_", "")
                                                      .replaceAll(widget.emial, ""), widget.emial)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(
                                            255, 225, 220, 1.0),
                                        borderRadius:
                                        BorderRadius.circular(30)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Text("${index+1}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 30,
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
