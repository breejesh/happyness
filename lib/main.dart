import 'package:happyness/screens/SigninScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
          backgroundColor: Colors.white,
          textTheme: TextTheme(
              title: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              subtitle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              display1: TextStyle(fontSize: 14))),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.black,
      ),
      home: SigninScreen(),
    );
  }
}
