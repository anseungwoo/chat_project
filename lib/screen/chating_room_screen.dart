import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/constant/size.dart';
import 'package:test_provider/models/chating_model.dart';
import 'package:test_provider/State/user_model_state.dart';
import 'package:test_provider/provider/chating_room_provider.dart';
import 'package:test_provider/repos/chat_net_repositoy.dart';


class ChatingRoomScreen extends StatefulWidget {
  final Function onMenuChanged;
  final String chatRoomId;
  final String otherUser;
  final String myUser;

  const ChatingRoomScreen(this.chatRoomId, this.otherUser, this.myUser,
      {Key key, this.onMenuChanged})
      : super(key: key);

  @override
  _ChatingRoomScreenState createState() => _ChatingRoomScreenState();
}

class _ChatingRoomScreenState extends State<ChatingRoomScreen> {
  TextEditingController messageController = TextEditingController();
  Stream<QuerySnapshot> chatMessagesStream;

  Widget chatMessages() {
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Expanded(
              child: ListView.builder(reverse: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                      message: snapshot.data.docs[index].data()["message"],
                      sendByMe: widget.myUser ==
                          snapshot.data.docs[index].data()["sendBy"],
                      name:widget.otherUser,
                    );
                  }),
            )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": widget.myUser,
        "chating_time": DateTime.now().millisecondsSinceEpoch
      };
      chatNetRepositoy.addConversationMessages(widget.chatRoomId, messageMap);
      setState(() {
        messageController.text = "";
      });
    }
  }

  @override
  void initState() {
    chatNetRepositoy.getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatMessagesStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          "채팅방"
        ),
        elevation: 0.0,
        centerTitle: false,
      ),
      body: Container(
          color: Color.fromRGBO(0, 100, 255, 0.2),
        child: Column(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              width: screenSize(context).width,
              child: Container(

                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: Color(0x54FFFFFF),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                              hintText: "메세지를 입력해주세요..",
                              hintStyle: TextStyle(
                                color: Colors.black26,
                                fontSize: 16,
                              ),
                              border: InputBorder.none
                          ),
                        )),

                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0x36FFFFFF),
                                    const Color(0x0FFFFFFF)
                                  ],
                                  begin: FractionalOffset.topLeft,
                                  end: FractionalOffset.bottomRight
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          padding: EdgeInsets.all(12),
                          child: Icon(Icons.add)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MessageTile extends StatelessWidget{
  final String message;
  final bool sendByMe;
  final String name;

 MessageTile({Key key, this.message, this.sendByMe, this.name}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    UserModelState userModelState =Provider.of<UserModelState>(context);
    return Container(
      color: Color.fromRGBO(0, 100, 255, 0.2),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: sendByMe
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            sendByMe ?  Container(): CircleAvatar(
              backgroundImage: NetworkImage(
                  userModelState.userModel
                      .profileImg),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: sendByMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(sendByMe?userModelState.userModel.email:name),
                  SizedBox(
                    width:
                    screenSize(context).width / 2.2,
                    child: Bubble(
                      color: Colors.white,
                      nip: sendByMe ? BubbleNip.rightTop: BubbleNip.leftTop,
                      child: Text(
                        message,
                        textAlign: sendByMe ? TextAlign.end : TextAlign
                            .start,),
                    ),
                  ),

                ],
              ),
            ),

            sendByMe ? CircleAvatar(
                backgroundImage: NetworkImage(
                    userModelState.userModel
                        .profileImg))
                : Container(),
          ],
        ),
      ),
    );
  }


}
