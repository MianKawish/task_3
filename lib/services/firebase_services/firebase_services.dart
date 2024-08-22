import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  CollectionReference<Map<String, dynamic>> userRef =
      FirebaseFirestore.instance.collection("users");

  Future<void> addNotesToDatabase(String text) async {
    final int docId = DateTime.now().millisecondsSinceEpoch;
    await userRef
        .doc(docId.toString())
        .set({"id": docId, "text": text, "timestamp": DateTime.now()});
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getUserData() async {
    return userRef.orderBy("timestamp", descending: true).snapshots();
  }
}
