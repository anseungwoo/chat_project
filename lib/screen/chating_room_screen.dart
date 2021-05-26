import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/constant/size.dart';
import 'package:test_provider/provider/chating_room_provider.dart';

class ChatingRoomScreen extends StatefulWidget {
  final Function onMenuChanged;

  const ChatingRoomScreen({Key key, this.onMenuChanged}) : super(key: key);

  @override
  _ChatingRoomScreenState createState() => _ChatingRoomScreenState();
}

class _ChatingRoomScreenState extends State<ChatingRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ChatingRoomProvider();
      },
      child: Consumer<ChatingRoomProvider>(
        builder: (BuildContext context, chatingRoomProvider, Widget child) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    color: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back)),
                          SizedBox(
                            width: screenSize(context).width / 30,
                          ),
                          Expanded(child: Text("채팅방 이름 775")),
                          SizedBox(
                            width: screenSize(context).width / 30,
                          ),
                          Icon(Icons.search),
                          SizedBox(
                            width: screenSize(context).width / 30,
                          ),
                          IconButton(
                            onPressed: (){
                              widget.onMenuChanged();
                            },
                              icon:(Icon(Icons.list_outlined))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Color.fromRGBO(0, 100, 255, 0.2),
                      child: ListView.builder(
                          reverse: true,
                          itemCount: chatingRoomProvider.messages.length,
                          itemBuilder: (BuildContext context, int index) {
                            //chatingRoomProvider.messages[index]
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://picsum.photos/200"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(

                                      children: [
                                        Text("이름"),
                                        SizedBox(
                                          width:
                                              screenSize(context).width / 2.2,
                                          child: Bubble(
                                            color: Colors.white,
                                            nip: BubbleNip.leftTop,
                                            child: Text(
                                                "${chatingRoomProvider.messages[index]}"),
                                          ),
                                        )
                                        //
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenSize(context).width / 30,
                      ),
                      Icon(Icons.photo),
                      Flexible(
                        child: TextField(
                          controller: chatingRoomProvider.messageContorller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: "여기에 입력하세요."),
                        ),
                      ),
                      InkWell(
                          splashColor: Colors.blue,
                          onTap: () {
                            chatingRoomProvider.setMessage();
                          },
                          child: Icon(Icons.airplanemode_active)),
                      SizedBox(
                        width: screenSize(context).width / 30,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
