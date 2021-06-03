import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:test_provider/constant/firestore_keys.dart';
import 'package:test_provider/constant/transformers.dart';

class SearchNetRepository with Transformers {
  getStoreId(String storeId) async {
    return await FirebaseFirestore.instance
        .collection(storeId).snapshots();
  }
}

SearchNetRepository searchNetRepository = SearchNetRepository();