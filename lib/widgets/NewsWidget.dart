import 'package:happyness/data/NewsArticle.dart';
import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  final NewsArticle newsArticle;

  NewsWidget(this.newsArticle, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  this.newsArticle.title,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
            Spacer(),
            Expanded(
              flex: 10,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(this.newsArticle.imageUrl),
                  ),
                ),
              ),
            ),
            Spacer(),
            Expanded(
              flex: 9,
              child: Text(
                this.newsArticle.body,
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.justify,
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Swipe left to view source',
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Swipe up to view next news',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
