import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:happyness/data/NewsArticle.dart';
import 'package:happyness/misc/PlatformViewVerticalGestureRecognizer.dart';
import 'package:happyness/widgets/NewsWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWrapperWidget extends StatelessWidget {
  final NewsArticle newsArticle;
  final VoidCallback toggleFloatingButton;
  NewsWrapperWidget(this.newsArticle, this.toggleFloatingButton, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController();
    final Completer<WebViewController> __webController =
        Completer<WebViewController>();
    Future<bool> _onBack() async {
      log('Showing _onBack');
      _pageController.jumpToPage(0);
      return false;
    }

    return PageView(
      controller: _pageController,
      onPageChanged: (int pageNum) => toggleFloatingButton(),
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        NewsWidget(newsArticle),
        Column(
          children: [
            NavigationControls(__webController.future, _pageController,
                newsArticle.sourceUrl),
            Expanded(
              child: WillPopScope(
                onWillPop: _onBack,
                child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: newsArticle.sourceUrl,
                  onWebViewCreated: (WebViewController webViewController) {
                    __webController.complete(webViewController);
                  },
                  gestureRecognizers: [
                    Factory(() =>
                        PlatformViewVerticalGestureRecognizer()), // Fix for webview and swiper gesture priority
                  ].toSet(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class NavigationControls extends StatelessWidget {
  NavigationControls(
      this._webViewControllerFuture, this._pageController, this.sourceURL)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;
  final PageController _pageController;
  final String sourceURL;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final WebViewController controller = snapshot.data;
        return Container(
          color: Theme.of(context).backgroundColor,
          child: Row(
            children: <Widget>[
              IconButton(
                color: Theme.of(context).textTheme.button.color,
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () async {
                  if (await controller.canGoBack()) {
                    await controller.goBack();
                  } else {
                    _pageController.jumpToPage(0);
                    return;
                  }
                },
              ),
              IconButton(
                color: Theme.of(context).textTheme.button.color,
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () async {
                  if (await controller.canGoForward()) {
                    await controller.goForward();
                  } else {
                    Scaffold.of(context).showSnackBar(
                      const SnackBar(content: Text("No forward history item")),
                    );
                    return;
                  }
                },
              ),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(sourceURL.split("://")[1].split("/")[0],
                          style: Theme.of(context).textTheme.subtitle2),
                    )),
              ),
              IconButton(
                color: Theme.of(context).textTheme.button.color,
                icon: const Icon(Icons.replay),
                onPressed: () {
                  controller.reload();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
