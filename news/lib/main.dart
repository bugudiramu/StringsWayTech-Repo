import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news/pages/homepage.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

// void main() => runApp(MyApp());
void main() {
  //enable in dev mode
  Crashlytics.instance.enableInDevMode = true;
  //record the error
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  // 
  runZoned<Future<void>>(
    () async {
      runApp(MyApp());
    },
    onError: Crashlytics.instance.recordError,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // routes: {
      //   '/hello': (BuildContext context) => MyHelloWorld(),
      // },
    );
  }
}
