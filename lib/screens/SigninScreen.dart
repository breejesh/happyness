import 'package:flutter/material.dart';
import 'package:happyness/screens/NewsScreen.dart';
import 'package:happyness/service/Authentication.dart';

class SigninScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: authenticationService.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return NewsScreen();
          } else {
            return SafeArea(
              child: Container(
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image(
                          image: AssetImage('assets/images/happyness_logo.png'),
                          height: 250,
                        ),
                      ),
                      OutlineButton(
                          onPressed: () => authenticationService.googleSignIn(),
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 10.0),
                          color: const Color(0xFFFFFFFF),
                          splashColor: Colors.white54,
                          borderSide: BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Image.asset(
                                'assets/images/google_logo.png',
                                height: 30.0,
                              ),
                              new Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: new Text(
                                    "Sign in with Google",
                                    style: TextStyle(color: Colors.white70),
                                  )),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
