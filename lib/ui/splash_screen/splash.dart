import 'dart:async';

import 'package:flutter/material.dart';
import 'package:puffzone/ui/home_screen/screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 2),
            () =>
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
        child: Image.asset('assets/logo.jpeg')
    );
  }
}
