import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleDatabase {
  final String? docId;

  ArticleDatabase({this.docId});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamArticle() {
    return firestore.collection('article').snapshots();
  }
}
