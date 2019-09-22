import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List list = [];
  static List list2=[];
  // static int i = 0;

  _getlbaord() {
    return leaderCard();
  }

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
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(
                top: 30.0, left: 20.0, right: 20.0, bottom: 5.0),
            color: Colors.black87,
            child: Card(
              elevation: 7.0,
              color: Colors.black87,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      // Expanded(child: leaderCard(120.0, Color(0Xffc7ecee))),
                      // customCard(),
                     SizedBox(width: 1.0),
                      Expanded(
                        child: _getlbaord(),
                        flex: 3,
                      ),
                      SizedBox(width: 1.0),
                      // Expanded(child: leaderCard(120.0, Color(0Xffc7ecee))),
                    ],
                  ),
                  SizedBox(
                    height: 18.0,
                    child: Container(
                      color: Colors.black87,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // height: 600.0,
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection('swleaderboard')
                              .orderBy("rating", descending: true)
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
                                    return Container(
                                      height: MediaQuery.of(context).size.height/9.35,
                                      //width: MediaQuery.of(context).size.width/2,
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey,
                                        border: Border.all(color: Colors.black87,width: 4),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      child: new ListTile(
                                        dense: true,
                                        //contentPadding: EdgeInsets.all(7),
                                        leading: Container(
                                          height: 40.0,
                                          width: 40.0,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.fitHeight,
                                                image: NetworkImage(
                                                    document['profile_pic']),
                                              )),
                                        ),
                                        title: new Text(document['name']
                                            .toString()
                                            .toUpperCase()),
                                        subtitle:
                                            new Text("\$ ${document['price']}"),
                                        trailing: Container(
                                          width: 50.0,
                                          height: 32.0,
                                          alignment: Alignment.center,
                                          child: Text(
                                            document['rating'],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Color(0xffe58e26),
                                          ),
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
          Positioned(
              left: 63,
              child: Icon(
                MdiIcons.crown,
                size: 35,
              )),
        ],
      ),
    );
  }

  Widget leaderCard() {
    return Container(
      height: 160,
      width: 200,
      // color: color,
      alignment: Alignment.center,
      child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('swleaderboard')
              .orderBy("rating", descending: true)
              .limit(3)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return LinearProgressIndicator();
            }
            return new GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 2,
              crossAxisSpacing: 4,
              childAspectRatio: 0.70,
              addRepaintBoundaries: true,
              reverse: true,
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                //i++;
                list.add(document.documentID);
                list2.add(document['profile_pic'].toString());
                return new Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: new BorderRadius.only(topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                        ),
                        child: Container(
                          //color: getcolor(document.documentID),

                          margin: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment(0.6,
                                0.0), // 10% of the width, so there are ten blinds.
                            colors: getcolor(
                                document.documentID), // whitish to gray
                            tileMode: TileMode.repeated,
                          )),
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Text(document['name']),
                              //  Text(document.documentID),
                              SizedBox(
                                height: 10,
                              ),
                              Text("\$" + document['price']),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: gettext(document.documentID),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: getbox(document.documentID)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -16,
                      left: 25,
                      
                      child: CircleAvatar(
                        radius: 27,
                        child: Image.network(document['profile_pic'],
                        height: 140,width: 100,
                        scale: 0.6,),
                      ),
                    ),
                  ],
                  overflow: Overflow.visible,
                );
              }).toList(),
              physics: const NeverScrollableScrollPhysics(),
            );
          }),
    );
  }

  getcolor(String document) {
    if (list.first == document)
      return [Colors.red, Colors.redAccent[100]];
    else if (list[1] == document)
      return [Colors.orange, Colors.orangeAccent[100]];
    else if (list[2] == document) return [Colors.blue, Colors.purpleAccent];

    return Colors.white60;
  }

  gettext(String document) {
    print(list);
    if (list.first == document)
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          "first.".toUpperCase(),
          style: TextStyle(color: Colors.amberAccent),
        ),
      );
    else if (list[1] == document)
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text("Second".toUpperCase(),
            style: TextStyle(color: Colors.yellow)),
      );
    else if (list[2] == document)
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child:
            Text("third".toUpperCase(), style: TextStyle(color: Colors.yellow)),
      );
  }

  getbox(String documentID) {
    if (list.first == documentID)
      return Colors.black;
    else
      return Colors.blue;
  }
}
