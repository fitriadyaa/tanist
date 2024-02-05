import 'package:cloud_firestore/cloud_firestore.dart';

class Plant {
  String id;
  String title;
  String kingdom;
  String family;
  String image;
  String desc;

  Plant(
      {required this.id,
      required this.title,
      required this.kingdom,
      required this.family,
      required this.image,
      required this.desc});

  factory Plant.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Plant(
        id: doc.id,
        title: data['title'],
        image: data['image'],
        kingdom: data['kingdom'],
        family: data['family'],
        desc: data['description']);
  }
}
