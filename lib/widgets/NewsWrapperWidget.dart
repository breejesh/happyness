import 'package:flutter/foundation.dart';
import 'package:happyness/data/NewsArticle.dart';
import 'package:happyness/misc/PlatformViewVerticalGestureRecognizer.dart';
import 'package:happyness/widgets/NewsWidget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWrapperWidget extends StatelessWidget {
  final NewsArticle newsArticle;
  final VoidCallback toggleFloatingButton;
  NewsWrapperWidget(this.newsArticle, this.toggleFloatingButton, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      onPageChanged: (int pageNum) => toggleFloatingButton(),
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        NewsWidget(newsArticle),
        Container(
          color: Theme.of(context).backgroundColor,
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: newsArticle.sourceUrl,
            gestureRecognizers: [
              Factory(() =>
                  PlatformViewVerticalGestureRecognizer()), // Fix for webview and swiper gesture priority
            ].toSet(),
          ),
        ),
      ],
    );
  }
}
