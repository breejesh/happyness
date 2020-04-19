import 'package:firstflutter/data/NewsArticle.dart';
import 'package:firstflutter/widgets/NewsWidget.dart';
import 'package:flutter/material.dart';

class NewsWrapperWidget extends StatelessWidget {
  final NewsArticle newsArticle;

  const NewsWrapperWidget(this.newsArticle, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        NewsWidget(newsArticle),
        Text(
          newsArticle.title,
          style: Theme.of(context).textTheme.subtitle,
        )
      ],
    );
  }
}
