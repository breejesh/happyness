import 'package:happyness/data/NewsArticle.dart';
import 'package:happyness/widgets/NewsWidget.dart';
import 'package:happyness/widgets/NewsWrapperWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.black,
  //     body: SafeArea(
  //       child: PageView(

  //         // physics: BouncingScrollPhysics(),
  //         scrollDirection: Axis.vertical,
  //         children: <Widget>[
  //           NewsWrapperWidget(newsArticles[0]),
  //           NewsWrapperWidget(newsArticles[1]),
  //           NewsWrapperWidget(newsArticles[2]),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  int _currentArticleNumber = 0;
  Widget _currentWidget;

  _NewsScreenState() {
    _currentWidget = NewsWrapperWidget(newsArticles[_currentArticleNumber]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapGR,
      child: AnimatedSwitcher(
        duration: Duration(seconds: 2500),
        child: _currentWidget,
      ),
    );
  }

  void tapGR() {
    setState(() {
      _currentArticleNumber = (++_currentArticleNumber) % 3;
      _currentWidget = NewsWrapperWidget(newsArticles[_currentArticleNumber]);
    });
  }
}
