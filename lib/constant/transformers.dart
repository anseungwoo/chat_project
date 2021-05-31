import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_provider/models/PostModel.dart';
import 'package:test_provider/models/firebase_auth_state.dart';
import 'package:test_provider/models/user_model.dart';

class Transformers {
  final toUser = StreamTransformer<DocumentSnapshot<Map<String, dynamic>>,
      UserModel>.fromHandlers(handleData: (snapshot, sink) async {
    sink.add(UserModel.fromSnapshot(snapshot));
  });

  final toUsers = StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
      List<UserModel>>.fromHandlers(handleData: (snapshot, sink) async {
    List<UserModel> users = [];
    User _user = await FirebaseAuth.instance.currentUser;
    snapshot.docs.forEach((documentSnapshot) {
      if (_user.uid != documentSnapshot.id)
        users.add(UserModel.fromSnapshot(documentSnapshot));
    });
    sink.add(users);
  });
  final touser = StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
      List<UserModel>>.fromHandlers(handleData: (snapshot, sink) async {
    List<UserModel> users = [];
    snapshot.docs.forEach((documentSnapshot) {
      users.add(UserModel.fromSnapshot(documentSnapshot));
    });
    sink.add(users);
  });
  final combineListOfUser =
  StreamTransformer<List<List<UserModel>>, List<UserModel>>.fromHandlers(
      handleData: (listOfPosts, sink) async {
        List<UserModel> users = [];
        for (final postList in listOfPosts) {
          users.addAll(postList);
        }
        sink.add(users);
      });


  final toPosts = StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
      List<PostModel>>.fromHandlers(handleData: (snapshot, sink) async {
    List<PostModel> posts = [];
    snapshot.docs.forEach((documentSnapshot) {
      posts.add(PostModel.fromSnapshot(documentSnapshot));
    });
    sink.add(posts);
  });


  final combineListOfPosts =
      StreamTransformer<List<List<PostModel>>, List<PostModel>>.fromHandlers(
          handleData: (listOfPosts, sink) async {
    List<PostModel> posts = [];

    for (final postList in listOfPosts) {
      posts.addAll(postList);
    }

    sink.add(posts);
  });
  final latestToTop =
  StreamTransformer<List<PostModel>, List<PostModel>>.fromHandlers(
      handleData: (posts, sink) async {
        posts.sort((a, b) => b.postTime.compareTo(a.postTime));
        sink.add(posts);
      });

}
