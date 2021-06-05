import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:test_provider/constant/generate_post_key.dart';
import 'package:test_provider/State/camera_state.dart';
import 'package:test_provider/State/user_model_state.dart';
import 'package:test_provider/screen/share_post_screen.dart';
import 'indicator.dart';

class CameraMainScreen extends StatefulWidget {
  const CameraMainScreen({
    Key key,
  }) : super(key: key);

  @override
  _CameraMainScreenState createState() => _CameraMainScreenState();
}

class _CameraMainScreenState extends State<CameraMainScreen> {
  Widget _progress = MyProgressIndicator();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<CameraState>(
      builder: (BuildContext context, CameraState cameraState, Widget child) {
        return Column(
          children: <Widget>[
            Container(

              width: size.width,
              height: size.width,
              color: Colors.black,
              child: (cameraState.isReadyToTakePhoto)
                  ? _getPreview(context, cameraState)
                  : _progress,

            ),
            Expanded(
              child: OutlineButton(
                onPressed: () {
                  if (cameraState.isReadyToTakePhoto) {

                    _attemptTakePhoto(cameraState, context);

                  }
                },
                shape: CircleBorder(),
                borderSide: BorderSide(color: Colors.black12, width: 20),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _getPreview(context, CameraState cameraState) {
    final Size size = MediaQuery.of(context).size;
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
              width: size.width,
              height: size.width / cameraState.controller.value.aspectRatio,
              child: CameraPreview(cameraState.controller)),
        ),
      ),
    );
  }

  void _attemptTakePhoto(CameraState cameraState, BuildContext context) async {
    final String postKey = getNewPostKey(
        Provider.of<UserModelState>(context, listen: false).userModel);
    try {
      final path = join((await getTemporaryDirectory()).path, '$postKey.png');

      XFile pick = await cameraState.controller.takePicture();
      File imageFile = File(pick.path);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => SharePostScreen(imageFile,postKey: postKey,)));
    } catch (e) {}
  }
}
