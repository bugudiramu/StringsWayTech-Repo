import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final List items = List.generate(20, (i) => i);
  @override
  Widget build(BuildContext context) {
    // final name = Firestore.instance
    //     .collection('swleaderboard')
    //     .document()
    //     .get()
    //     .then((DocumentSnapshot ds) {
    //   return ds['name'].toString();
    // });
    // final price = Firestore.instance
    //     .collection('swleaderboard')
    //     .document()
    //     .get()
    //     .then((DocumentSnapshot ds) {
    //   return ds['price'].toString();
    // });
    return Scaffold(
      appBar: AppBar(
        title: Text('LeaderBoard'.toUpperCase()),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(
            top: 30.0, left: 20.0, right: 20.0, bottom: 5.0),
        color: Color(0Xffc7ecee),
        child: Card(
          elevation: 7.0,
          color: Color(0Xffc7ecee),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(child: leaderCard(120.0, Color(0Xffc7ecee))),
                  // customCard(),
                  SizedBox(width: 1.0),
                  leaderCard(140.0, Colors.white70),
                  SizedBox(width: 1.0),
                  Expanded(child: leaderCard(120.0, Color(0Xffc7ecee))),
                ],
              ),
              SizedBox(
                height: 3.0,
                child: Container(
                  color: Color(0Xaaced6e0),
                ),
              ),
              Expanded(
                child: Container(
                  // height: 600.0,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection('swleaderboard')
                          .orderBy("rating",descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text(snapshot.error);
                        }
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(child: new Text('Loading...'));
                          default:
                            return new ListView(
                              children: snapshot.data.documents
                                  .map((DocumentSnapshot document) {
                                return new ListTile(
                                  leading: Container(
                                    height: 80.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              document['profile_pic']),
                                        )),
                                  ),
                                  title: new Text(document['name']
                                      .toString()
                                      .toUpperCase()),
                                  subtitle: new Text("\$ ${document['price']}"),
                                  trailing: Container(
                                    width: 50.0,
                                    height: 32.0,
                                    alignment: Alignment.center,
                                    child: Text(
                                      document['rating'],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Color(0xffe58e26),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget leaderCard(double width, Color color) {
    return GestureDetector(
      onTap: () {
        print("GestureDetector tapped!");
      },
      child: Container(
        alignment: Alignment.center,
        // color: Colors.white70,
        color: color,
        height: 140.0,
        // width: 120.0,
        width: width,
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: <Widget>[
            Container(
              child: CircleAvatar(),
            ),
            SizedBox(height: 5.0),
            Text(
              "Harry",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2.0),
            Text(
              "\$ 130",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.blue,
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
              child: Text("First".toUpperCase(),
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
