import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:test_provider/constant/imafe_helper.dart';

class ImageNetRepository{
  Future<TaskSnapshot> uploadImage(File originImage,
      {@required String postKey}) async {
    try {
      final File resized = await compute(getResizedImage, originImage);
      final firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref().child(_getImagePathByPostKey(postKey));
      final firebase_storage.UploadTask uploadTask = storageReference.putFile(resized);
     return uploadTask;
    } catch (e) {
      print(e);
      return null;
    }
  }

  String _getImagePathByPostKey(String postKey) => 'post/$postKey/post.jpg';

  Future<dynamic> getPostImageUrl(String postKey) {
    return firebase_storage.FirebaseStorage.instance
        .ref()
        .child(_getImagePathByPostKey(postKey))
        .getDownloadURL();
  }

}
ImageNetRepository imageNetRepository = ImageNetRepository();