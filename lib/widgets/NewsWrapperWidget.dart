import 'package:happyness/data/NewsArticle.dart';
import 'package:happyness/widgets/NewsWidget.dart';
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
        Container(
          color: Theme.of(context).backgroundColor,
          child: Text(
            newsArticle.title,
            style: Theme.of(context).textTheme.subtitle,
          ),
        )
      ],
    );
  }
}
