import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_provider/constant/firestore_keys.dart';
import 'package:test_provider/constant/transformers.dart';
import 'package:test_provider/models/PostModel.dart';

class PostNetRepository with Transformers{

  Future<Map<String, dynamic>> createNewPost(
      String postKey, Map<String, dynamic> postData) async {
    final DocumentReference postRef =
    FirebaseFirestore.instance.collection(COLLECTION_POSTS).doc(postKey);
    final DocumentSnapshot postSnapshot = await postRef.get();
    final DocumentReference userRef = FirebaseFirestore.instance
        .collection(COLLECTION_USERS)
        .doc(postData[KEY_USERKEY]);

    // ignore: missing_return
    return FirebaseFirestore.instance.runTransaction((Transaction tx) async {
      if (!postSnapshot.exists) {
        tx.set(postRef, postData);
        tx.update(userRef, {
          KEY_POSTKEY: FieldValue.arrayUnion([postKey])
        });
      }
    });
  }

  Future<void> updatePostImageUrl({String postImg, String postKey}) async {
    final DocumentReference postRef =
    FirebaseFirestore.instance.collection(COLLECTION_POSTS).doc(postKey);
    final DocumentSnapshot postSnapshot = await postRef.get();

    if (postSnapshot.exists) {
      await postRef.update({KEY_PROFILEIMG: postImg});
    }
  }

  Stream<List<PostModel>> getPostsFromSpecificUser(String userKey) {
    return FirebaseFirestore.instance
        .collection(COLLECTION_POSTS)
        .where(KEY_USERKEY, isEqualTo: userKey)
        .snapshots()
        .transform(toPosts);
  }
  Stream<List<PostModel>> fetchPostFromAllFollowers(List<dynamic> followings) {
    final CollectionReference collectionRefernce =
    FirebaseFirestore.instance.collection(COLLECTION_POSTS);
    List<Stream<List<PostModel>>> streams = [];

    for (final following in followings) {
      streams.add(collectionRefernce
          .where(KEY_USERKEY, isEqualTo: following)
          .snapshots()
          .transform(toPosts));
    }
    return CombineLatestStream.list<List<PostModel>>(streams)
        .transform(combineListOfPosts)
        .transform(latestToTop);
  }

}
PostNetRepository postNetRepository = PostNetRepository();