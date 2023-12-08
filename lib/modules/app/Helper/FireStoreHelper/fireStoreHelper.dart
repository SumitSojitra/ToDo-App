import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  FireStoreHelper._();

  static final FireStoreHelper fireStoreHelper = FireStoreHelper._();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  addTasks({required Map<String, dynamic> tasks}) async {
    await firebaseFirestore
        .collection("Tasks")
        .doc("${tasks['task']}")
        .set(tasks);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchTasks() {
    Stream<QuerySnapshot<Map<String, dynamic>>> data =
        firebaseFirestore.collection("Tasks").snapshots();
    return data;
  }

  deleteTask({required String id}) {
    firebaseFirestore.collection("Tasks").doc("${id}").delete();
  }
}
