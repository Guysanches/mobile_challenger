import 'dart:async';

import 'package:app_snowman/core/themes/app_colors.dart';
import 'package:app_snowman/views/content/home_Page.dart';
import 'package:flutter/material.dart';

class SplashComponent extends StatefulWidget {
  @override
  _SplashComponentState createState() => _SplashComponentState();
}

class _SplashComponentState extends State<SplashComponent> {
  final int navigateAfterSeconds = 5;

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(
          seconds: navigateAfterSeconds,
        ), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.ease;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(AppColors.splashColor),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Snowlabs.png"),
              fit: BoxFit.none,
            ),
          ),
        ));
  }
}
