import 'package:flutter/material.dart';
import 'package:leaderboard/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
       // primaryColor: Color(0Xffc7ecee),
       brightness: Brightness.dark
      ),
    );
  }
}
