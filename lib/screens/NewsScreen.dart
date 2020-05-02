import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:happyness/data/NewsArticle.dart';
import 'package:happyness/widgets/NewsWrapperWidget.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/indicator/line_scale_indicator.dart';
import 'package:loading/loading.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  static GlobalKey keyForScreenshot = new GlobalKey();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _showFloatingButton = true;
  bool _showSwiper = true;
  List<NewsArticle> newsArticles = [];

  @override
  Widget build(BuildContext context) {
    if (newsArticles.length == 0) {
      return Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    image: AssetImage('assets/images/happyness_logo.png'),
                    height: 160,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Loading(
                    indicator: LineScaleIndicator(),
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        floatingActionButton: _showFloatingButton
            ? SpeedDial(
                // both default to 16

                animatedIcon: AnimatedIcons.menu_close,
                animatedIconTheme: IconThemeData(size: 22),
                // this is ignored if animatedIcon is non null
                // child: Icon(Icons.add),
                // If true user is forced to close dial manually
                // by tapping main button and overlay is not rendered.
                closeManually: false,
                curve: Curves.easeIn,
                overlayColor: Colors.black,
                overlayOpacity: 0.4,
                onOpen: () => print('OPENING DIAL'),
                onClose: () => print('DIAL CLOSED'),
                tooltip: 'Speed Dial',
                heroTag: 'speed-dial-hero-tag',
                elevation: 8.0,
                shape: CircleBorder(),
                children: [
                  SpeedDialChild(
                      child: Icon(Icons.share),
                      backgroundColor: Colors.green,
                      label: 'Share',
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      onTap: () => takeScreenShotAndShare()),
                  SpeedDialChild(
                    child: Icon(Icons.arrow_upward),
                    backgroundColor: Colors.orange,
                    label: 'Go to Top',
                    labelStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    onTap: () => redraw(),
                  )
                ],
              )
            : null,
        resizeToAvoidBottomInset:
            false, // Fix for keyboard resizing issue - not sure how viable when we want to actually use keyboard
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: RepaintBoundary(
              // Moved here so screenshot does not take floating button
              key: keyForScreenshot,
              child: _showSwiper
                  ? Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return new NewsWrapperWidget(
                          newsArticles[index],
                          toggleFloatingButton,
                        );
                      },
                      loop: false,
                      scrollDirection: Axis.vertical,
                      itemWidth: MediaQuery.of(context).size.width,
                      itemHeight: MediaQuery.of(context).size.height,
                      layout: SwiperLayout.STACK,
                      itemCount: newsArticles.length,
                    )
                  : null,
            ),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    firebaseCloudMessagingListeners();
    // this.getArticlesFromFirestore().then((data) => setState(() {
    //       this.newsArticles = data;
    //       log(this.newsArticles.toString());
    //     }));

    endLoadingAfterDelay(3).then((_) => setState(() {
          this.newsArticles = staticNewsArticles;
        }));
  }

  Future endLoadingAfterDelay(int delayInSeconds) async {
    // Imagine that this function is more complex and slow
    return Future.delayed(Duration(seconds: delayInSeconds), () => {});
  }

  void firebaseCloudMessagingListeners() {
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.subscribeToTopic("new_news_notification");

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void redraw() {
    // Hack.. find something better
    setState(() {
      log('Hiding Swiper');
      _showSwiper = !_showSwiper;
      // showSomeAnimation
      // Use some callback instead of delay
      Future.delayed(const Duration(milliseconds: 20), () {
        setState(() {
          log('Showing Swiper');
          _showSwiper = !_showSwiper;
        });
      });
    });
  }

  void toggleFloatingButton() {
    setState(() {
      _showFloatingButton = !_showFloatingButton;
    });
  }

  Future<void> takeScreenShotAndShare() async {
    try {
      RenderRepaintBoundary boundary =
          keyForScreenshot.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage();
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      await Share.file('Share a screenshot of Happyness!', 'happynews.png',
          pngBytes, 'image/png',
          text: 'Download Happyness App for more: https://www.google.com');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<List<NewsArticle>> getArticlesFromFirestore() async {
    Firestore _db = Firestore.instance;
    List<NewsArticle> news = [];
    await _db.collection('news').getDocuments().then(
        (QuerySnapshot snapshot) => snapshot.documents.forEach((newsItem) {
              NewsArticle article = new NewsArticle(
                  newsItem.data['title'],
                  newsItem.data['summary'],
                  newsItem.data['cover_image_url'],
                  newsItem.data['source_url']);
              newsArticles.add(article);
            }));
    return news;
  }
}
