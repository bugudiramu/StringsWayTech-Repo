import 'package:book/postScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blocs/postProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => PostBloc(),
      child: MaterialApp(
        home: PostHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
