import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:news/tabs/eventstab.dart';
import 'package:news/tabs/newstab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Uri deepLink;
  @override
  void initState() {
    super.initState();
    this.initDynamicLinks();
  }

  void initDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    print(deepLink);

    if (deepLink != null) {
      Navigator.pushNamed(context, deepLink.path);
    }

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        Navigator.pushNamed(context, deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
  }

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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.card_membership),
              onPressed: () {
                // Crashlytics.instance.getVersion();
                Crashlytics.instance.crash();
              },
            ),
          ],
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
