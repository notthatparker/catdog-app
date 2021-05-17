import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:catdog/Splashscreen.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:catdog/Home.dart';

class MySplashscreen extends StatefulWidget {
  @override
  _MySplashscreenState createState() => _MySplashscreenState();
}

class _MySplashscreenState extends State<MySplashscreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds:
          Home(), //we can use navigateafterfuture if we are waiting for data to load async
      title: Text('catdog',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.amber)),
      backgroundColor: Colors.white,
      image: Image.asset('assets/images/catdog.png'),
      photoSize: 200,
      loaderColor: Colors.amber[900],
    );
  }
}
