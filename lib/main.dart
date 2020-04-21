import 'package:flutter/services.dart';
import 'package:happyness/screens/NewsScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Force portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // Actual App
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Happyness',
      theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
          backgroundColor: Colors.white,
          textTheme: Typography.blackCupertino), // Using factory themes
      darkTheme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.black,
          textTheme: Typography.whiteCupertino), // Using factory themes
      home: NewsScreen(),
    );
  }
}
