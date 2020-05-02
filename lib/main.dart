import 'package:happyness/screens/NewsScreen.dart';
import 'package:happyness/screens/SigninScreen.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
        textTheme: Typography.whiteCupertino,
      ),
      home: NewsScreen(),
    );
  }
}
