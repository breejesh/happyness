import 'package:happyness/data/NewsArticle.dart';
import 'package:happyness/widgets/NewsWidget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWrapperWidget extends StatelessWidget {
  final NewsArticle newsArticle;

  const NewsWrapperWidget(this.newsArticle, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        NewsWidget(newsArticle),
        WebView(
          initialUrl: newsArticle.sourceUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ],
    );
  }
}
