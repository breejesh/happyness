import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:happyness/data/NewsArticle.dart';
import 'package:happyness/widgets/NewsWrapperWidget.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Swiper(
        onIndexChanged: onIndexChanged,
        itemBuilder: (BuildContext context, int index) {
          return new NewsWrapperWidget(newsArticles[index]);
        },
        loop: false,
        scrollDirection: Axis.vertical,
        itemWidth: MediaQuery.of(context).size.width,
        itemHeight: MediaQuery.of(context).size.height,
        layout: SwiperLayout.STACK,
        itemCount: newsArticles.length,
      )),
    );
  }

  void onIndexChanged(int index) {
    _currentIndex = index;
    log('onIndexChanged index: $index');
  }
}
