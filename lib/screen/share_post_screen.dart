import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/constant/size.dart';
import 'package:test_provider/models/PostModel.dart';
import 'package:test_provider/models/user_model.dart';
import 'package:test_provider/models/user_model_state.dart';

import 'package:test_provider/repos/image_net_repository.dart';
import 'package:test_provider/repos/post_net_repository.dart';
import 'package:test_provider/repos/user_net_repository.dart';
import 'package:test_provider/screen/indicator.dart';

class SharePostScreen extends StatefulWidget {
  final File imageFile;
  final String postKey;

  const SharePostScreen(this.imageFile, {Key key, @required this.postKey})
      : super(key: key);

  @override
  _SharePostScreenState createState() => _SharePostScreenState();
}

class _SharePostScreenState extends State<SharePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text(
          '프로필사진,배경사진변경',
          style: TextStyle(color: Colors.black),
        ),

      ),

      body: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            leading: Image.file(
              widget.imageFile,
              width: screenSize(context).width / 6,
              height: screenSize(context).width / 6,
              fit: BoxFit.cover,
            ),
            title: Text("메인화면 변경하기"),
          ),
            TextButton(
              onPressed: () async {
                showModalBottomSheet(
                    context: context,
                    builder: (_) => MyProgressIndicator(),
                    isDismissible: false,
                    enableDrag: false);
                await imageNetRepository.uploadImage(widget.imageFile, postKey: widget.postKey);
                UserModel usermodel = Provider
                    .of<UserModelState>(context, listen: false)
                    .userModel;
                await postNetRepository.createNewPost(widget.postKey,
                    PostModel.getMapForCreatePost(userKey: usermodel.userKey,
                      username: usermodel.username,));

                String postImgLink=await imageNetRepository.getPostImageUrl(widget.postKey);
                await postNetRepository.updatePostImageUrl(postKey: widget.postKey,postImg: postImgLink);
                await userNetRepository.composts(userKey:usermodel.userKey,post: postImgLink );

                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text(
                "사진바꾸기",
                textScaleFactor: 1.4,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            leading: Image.file(
              widget.imageFile,
              width: screenSize(context).width / 6,
              height: screenSize(context).width / 6,
              fit: BoxFit.cover,
            ),
            title: Text("뒷배경 변경하기"),
          ),
          TextButton(
            onPressed: () async {
              showModalBottomSheet(
                  context: context,
                  builder: (_) => MyProgressIndicator(),
                  isDismissible: false,
                  enableDrag: false);
              await imageNetRepository.uploadImage(widget.imageFile, postKey: widget.postKey);
              UserModel usermodel = Provider
                  .of<UserModelState>(context, listen: false)
                  .userModel;
              await postNetRepository.createNewPost(widget.postKey,
                  PostModel.getMapForCreatePost(userKey: usermodel.userKey,
                    username: usermodel.username,));

              String postImgLink=await imageNetRepository.getPostImageUrl(widget.postKey);
              await postNetRepository.updateBackImageUrl(postKey: widget.postKey,postImg: postImgLink);
              await userNetRepository.baposts(userKey:usermodel.userKey,post: postImgLink );

              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              "사진바꾸기",
              textScaleFactor: 1.4,
              style: TextStyle(color: Colors.black),
            ),
          )
          ],
      ),
    );
  }
}

