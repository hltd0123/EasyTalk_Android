import 'package:dacn/Views/WidgetBuiding/PreviewArticle.dart';
import 'package:flutter/material.dart';

class PreviewArticleContainer extends StatelessWidget {
  final List<PreviewArticle> articles;

  const PreviewArticleContainer({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView(
        scrollDirection: Axis.horizontal, // Chạy theo chiều ngang
        children: articles,
      ),
    );
  }
}

