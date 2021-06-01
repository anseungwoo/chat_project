// import 'package:flutter/material.dart';
// import 'package:test_provider/constant/size.dart';
//
// import 'add_chat_room_screen.dart';
// import 'chating_room_screen.dart';
//
// class ChatingRoomFriendListScreen extends StatefulWidget {
//   @override
//   _ChatingRoomFriendListScreenState createState() =>
//       _ChatingRoomFriendListScreenState();
// }
//
// class _ChatingRoomFriendListScreenState
//     extends State<ChatingRoomFriendListScreen> {
//   final duration = Duration(milliseconds: 300);
//   MenuStatus _menuStatus = MenuStatus.closed;
//   double bodyXPos = 0;
//   double menuXPos = 2000;
//   double conXPos = 2000;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           backgroundColor: Colors.black26,
//           body: Stack(children: <Widget>[
//             AnimatedContainer(
//               duration: duration,
//               curve: Curves.fastOutSlowIn,
//               child: ChatingRoomScreen(onMenuChanged: () {
//                 setState(() {
//                   _menuStatus = (_menuStatus == MenuStatus.closed)
//                       ? MenuStatus.opened
//                       : MenuStatus.closed;
//                   switch (_menuStatus) {
//                     case MenuStatus.opened:
//                       bodyXPos = 0;
//                       menuXPos = screenSize(context).width/2;
//                       conXPos =0;
//
//                       break;
//                     case MenuStatus.closed:
//                       bodyXPos = 0;
//                       menuXPos = screenSize(context).width;
//                       conXPos= screenSize(context).width;
//                       break;
//                   }
//                 });
//               }),
//               transform: Matrix4.translationValues(bodyXPos, 0, 0),
//             ),
//             AnimatedContainer(
//               duration: duration,
//               curve: Curves.fastOutSlowIn,
//               transform: Matrix4.translationValues(conXPos, 0, 0),
//               child: Container(
//                   width: screenSize(context).width/2,
//                   color: Color.fromRGBO(0, 0, 0, 0.3),
//                 child: InkWell(onTap: (){setState(() {
//                   _menuStatus = (_menuStatus == MenuStatus.closed)
//                       ? MenuStatus.opened
//                       : MenuStatus.closed;
//                   switch (_menuStatus) {
//                     case MenuStatus.opened:
//                       bodyXPos = 0;
//                       menuXPos = screenSize(context).width/2;
//                       conXPos =0;
//
//                       break;
//                     case MenuStatus.closed:
//                       bodyXPos = 0;
//                       menuXPos = screenSize(context).width;
//                       conXPos= screenSize(context).width;
//                       break;
//                   }
//                 });
//
//                 },),
//                 ),
//               ),
//             AnimatedContainer(
//               duration: duration,
//               curve: Curves.fastOutSlowIn,
//               transform: Matrix4.translationValues(menuXPos, 0, 0),
//               child: Container(
//                 width: screenSize(context).width / 2,
//                 color: Colors.white,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         IconButton(
//                             icon: Icon(Icons.arrow_back),
//                             onPressed: () {
//                               setState(() {
//                                 _menuStatus = (_menuStatus == MenuStatus.closed)
//                                     ? MenuStatus.opened
//                                     : MenuStatus.closed;
//                                 switch (_menuStatus) {
//                                   case MenuStatus.opened:
//                                     bodyXPos = 0;
//                                     menuXPos = screenSize(context).width / 2;
//                                     conXPos =0;
//
//                                     break;
//                                   case MenuStatus.closed:
//                                     bodyXPos = 0;
//                                     menuXPos = screenSize(context).width;
//                                     conXPos= screenSize(context).width;
//                                     break;
//                                 }
//                               });
//                             }),
//                         Text("채팅방목록"),
//                       ],
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: ListView.builder(
//                             itemCount: 10,
//                             itemBuilder: (BuildContext context, int index) {
//                               if (index == 0) {
//                                 return InkWell(
//                                   splashColor: Colors.grey,
//                                   onTap: (){
//                                     Navigator.push(context, MaterialPageRoute(builder: (_)=>AddChatRoomScreen()));
//
//                                   },
//                                   child: Row(
//                                     children: [
//                                       Icon(
//                                         Icons.add_circle,
//                                         size: 55,
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Text("친구초대"),
//                                     ],
//                                   ),
//                                 );
//                               }
//                               if (index == 1) {
//                                 return Row(
//                                   children: [
//                                     CircleAvatar(
//                                       backgroundImage: NetworkImage(
//                                           "https://picsum.photos/200"),
//                                       radius: 25,
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text("내이름"),
//                                   ],
//                                 );
//                               }
//                               return Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 0, top: 8, bottom: 8, right: 0),
//                                 child: Row(
//                                   children: [
//                                     CircleAvatar(
//                                       backgroundImage: NetworkImage(
//                                           "https://picsum.photos/200"),
//                                       radius: 25,
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text("친구이름"),
//                                   ],
//                                 ),
//                               );
//                             }),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ])),
//     );
//   }
// }
//
// enum MenuStatus { opened, closed }
