import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tanist/widgets/date_time.dart';

class Article {
  String id;
  String title;
  String author;
  String content;
  DateTime? date;
  String image;
  String imageAuthor;
  String tipe;

  Article({
    required this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.date,
    required this.image,
    required this.imageAuthor,
    required this.tipe,
  });

  factory Article.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Article(
        id: doc.id,
        title: data['title'] ?? '',
        author: data['author'] ?? '',
        content: data['content'] ?? '',
        date: DateTimeUtils.toDateTime(data['date']),
        image: data['image'],
        imageAuthor: data['imageAuthor'],
        tipe: data['tipe']);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'content': content,
      'date': date,
      'image': image,
      'imageAuthor': imageAuthor,
      'tipe': tipe,
    };
  }
}
