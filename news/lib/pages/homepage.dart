import 'package:flutter/material.dart';
import 'package:news/eventstab.dart';
import 'package:news/newstab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("StringsWayTech News"),
          backgroundColor: Colors.red,
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(text: "News"),
              Tab(text: "Events"),
            ],
          ),
        ),
        body: Container(
          child: TabBarView(
            children: <Widget>[
              NewsTab(),
              EventsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
