import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:news/pages/helloworld.dart';

class DetaileNews extends StatefulWidget {
  final String title;
  final String image;
  final String desc;
  final String pubby;
  final int id;
  DetaileNews({
    this.title,
    this.image,
    this.desc,
    this.pubby,
    this.id,
  });
  @override
  _DetaileNewsState createState() => _DetaileNewsState();
}

class _DetaileNewsState extends State<DetaileNews> {
  @override
  void initState() {
    super.initState();
    this.initDynamicLinks();
  }

  void initDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHelloWorld()));
    }
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      print('Success');
      final Uri deepLink = dynamicLink?.link;
      if (deepLink != null) {
        Navigator.pushNamed(context, deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      print('Error');
      print(e.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Article"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 20.0, left: 10.0, right: 10.0),
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              // padding: const EdgeInsets.only(
              //     top: 10.0, bottom: 20.0, left: 10.0, right: 10.0),
              child: ListTile(
                title: Row(
                  children: <Widget>[
                    Text("By "),
                    Text(
                      widget.pubby == null ? "Ananymous" : widget.pubby,
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                ),
              ),
            ),
            Hero(
              tag: widget.id,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  "${widget.image}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 20.0, left: 10.0, right: 10.0),
              child: Text(
                widget.desc,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
