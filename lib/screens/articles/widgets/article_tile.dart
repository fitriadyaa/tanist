import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tanist/screens/articles/artiicle_detail_screen.dart';
import 'package:tanist/screens/articles/resources/article_model.dart';

class ArticleTile extends StatelessWidget {
  final Article article;

  const ArticleTile({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            child: ArticleDetailScreen(
              article: article,
            ),
            type: PageTransitionType.rightToLeft,
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          children: [
            Image.network(article.image),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(article.imageAuthor),
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(article.author),
                          Text(article.date.toString()),
                        ],
                      ),
                    ],
                  ),
                  // Add other Widgets for icons or additional information
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
