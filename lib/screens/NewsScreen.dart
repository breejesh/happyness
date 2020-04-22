import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:happyness/data/NewsArticle.dart';
import 'package:happyness/widgets/NewsWrapperWidget.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  static GlobalKey scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: scaffoldKey,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.share),
          onPressed: onShare,
        ),
        resizeToAvoidBottomInset:
            false, // Fix for keyboard resizing issue - not sure how viable when we want to actually use keyboard
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Swiper(
            index: 3,
            itemBuilder: (BuildContext context, int index) {
              return new NewsWrapperWidget(newsArticles[index]);
            },
            loop: false,
            scrollDirection: Axis.vertical,
            itemWidth: MediaQuery.of(context).size.width,
            itemHeight: MediaQuery.of(context).size.height,
            layout: SwiperLayout.STACK,
            itemCount: newsArticles.length,
          ),
        ),
      ),
    );
  }

  Future<void> onShare() async {
    log('onShare: ');
    await takeScreenShotAndShare();
  }

  Future<void> takeScreenShotAndShare() async {
    try {
      RenderRepaintBoundary boundary =
          scaffoldKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage();
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      await Share.file('Share a screenshot of Happyness!', 'goodnews.png',
          pngBytes, 'image/png',
          text: 'Download Happyness for more');
    } catch (e) {
      print('error: $e');
    }
  }
}
