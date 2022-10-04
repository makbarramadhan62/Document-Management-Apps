import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kp_project/FrontEnd/Screens/Splash/splashScreen.dart';
import 'package:kp_project/utilities/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kp_project',
      home: SplashScreen(),
      theme: ThemeData(scaffoldBackgroundColor: kPrimaryClr),
      debugShowCheckedModeBanner: false,
    );
  }
}
