import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_provider/models/user_model.dart';

class Transformers{
  final toUser = StreamTransformer<DocumentSnapshot<Map<String, dynamic>>, UserModel>.fromHandlers(
      handleData: (snapshot, sink) async {
        sink.add(UserModel.fromSnapshot(snapshot));
      });
}