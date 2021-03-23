import 'package:flutter/material.dart';
import 'core/themes/app_colors.dart';
import 'views/content/splash_Page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snowman Labs',
      theme: ThemeData(
        primaryColor: Color(AppColors.colorMain),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashContent(),
    );
  }
}
