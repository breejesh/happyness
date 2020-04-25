import 'package:flutter/material.dart';
import 'package:happyness/screens/NewsScreen.dart';
import 'package:happyness/service/Authentication.dart';

class SigninScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: authenticationService.user,
        builder: (context, snapshot) {
          // if(snapshot.hasData) {
          //   authenticationService.signOut();
          // }
          if (snapshot.hasData) {
            return NewsScreen();
          } else {
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        onPressed: () => authenticationService.googleSignIn(),
                        padding:
                            EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
                        color: const Color(0xFFFFFFFF),
                        child: new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Image.asset(
                              'assets/images/google_button.jpg',
                              height: 40.0,
                            ),
                            new Container(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: new Text(
                                  "Sign in with Google",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        )),
                  ],
                ),
              ),
            );
          }
        });
  }
}
