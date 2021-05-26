import 'package:flutter/material.dart';
import 'package:test_provider/constant/size.dart';

class MyProgressIndicator extends StatelessWidget {
  final double containerSize;
  final double progressSize;

  const MyProgressIndicator(
      {Key key, this.containerSize, this.progressSize = 60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: screenSize(context).width,
        height: containerSize,
        child: Center(
            child: SizedBox(
                height: progressSize,
                width: progressSize,
                child: Image.asset('image/loding.gif'))));
  }
}