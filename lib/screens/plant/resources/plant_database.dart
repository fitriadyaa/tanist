import 'package:cloud_firestore/cloud_firestore.dart';

class PlantDatabase {
  final String? docId;

  PlantDatabase({this.docId});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamArticle() {
    return firestore.collection('plant').snapshots();
  }
}
