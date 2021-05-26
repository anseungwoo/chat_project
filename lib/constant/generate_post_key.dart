import 'package:test_provider/models/user_model.dart';

String getNewPostKey(UserModel userModel) =>
    "${DateTime.now().millisecondsSinceEpoch}_${userModel.userKey}";