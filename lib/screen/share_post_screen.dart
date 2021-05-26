import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/constant/size.dart';
import 'package:test_provider/models/PostModel.dart';
import 'package:test_provider/models/user_model.dart';
import 'package:test_provider/models/user_model_state.dart';
import 'package:test_provider/repos/image_net_repository.dart';
import 'package:test_provider/repos/post_net_repository.dart';
import 'package:test_provider/screen/indicator.dart';

class SharePostScreen extends StatelessWidget {
  final File imageFile;
  final String postKey;

  const SharePostScreen(this.imageFile, {Key key, @required this.postKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: Text(
          '프로필사진,배경사진변경',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              showModalBottomSheet(
                  context: context,
                  builder: (_) => MyProgressIndicator(),
                  isDismissible: false,
                  enableDrag: false);
              await imageNetRepository.uploadImage(imageFile, postKey: postKey);
              UserModel usermodel = Provider
                  .of<UserModelState>(context, listen: false)
                  .userModel;
              await postNetRepository.createNewPost(postKey,
                  PostModel.getMapForCreatePost(userKey: usermodel.userKey,
                      username: usermodel.username,));

              String postImgLink=await imageNetRepository.getPostImageUrl(postKey);

              await postNetRepository.updatePostImageUrl(postKey: postKey,postImg: postImgLink);

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
      body: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            leading: Image.file(
              imageFile,
              width: screenSize(context).width / 6,
              height: screenSize(context).width / 6,
              fit: BoxFit.cover,
            ),
            title: Text("메인화면 변경하기"),
          )
        ],
      ),
    );
  }

}

