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
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  this.newsArticle.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Spacer(),
            Expanded(
              flex: 10,
              child: Stack(
                children: <Widget>[
                  Center(
                      child: Text(
                      'Loading...',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: this.newsArticle.imageUrl != null
                            ? NetworkImage(this.newsArticle.imageUrl)
                            : AssetImage('assets/images/AltoAdventure.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Text(
                  this.newsArticle.body,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.justify,
                ),
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
