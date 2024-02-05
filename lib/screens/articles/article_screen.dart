import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tanist/screens/articles/resources/article_database.dart';
import 'package:tanist/screens/articles/resources/article_model.dart';
import 'package:tanist/screens/articles/widgets/article_tile.dart';
import 'package:tanist/widgets/date_time.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artikel'),
        backgroundColor: const Color(0xFF219653),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: ArticleDatabase().streamArticle(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF219653),
              ),
            );
          }

          List<DocumentSnapshot<Map<String, dynamic>>> documents =
              snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot<Map<String, dynamic>> document =
                  documents[index];
              Article article = Article(
                  title: document['title'],
                  author: document['author'],
                  content: document['desc'],
                  date: DateTimeUtils.toDateTime(document['date']),
                  id: '',
                  image: document['image'],
                  imageAuthor: document['imageAuthor'],
                  tipe: document['tipe']);

              return ArticleTile(article: article);
            },
          );
        },
      ),
    );
  }
}
