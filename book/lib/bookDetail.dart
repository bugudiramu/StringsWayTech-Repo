import 'package:flutter/material.dart';

class BookDetail extends StatefulWidget {
  final String subName;
  final String subCode;
  final String image;

  BookDetail({this.subName, this.subCode, this.image});
  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BookDetail"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 400.0,
              width: double.infinity,
              child: Image.asset(
                widget.image,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.topLeft,
              child: Row(
                children: <Widget>[
                  Text(
                    "Subject Name: ",
                    style: Theme.of(context).textTheme.title,
                  ),
                  Expanded(
                    child: Text(
                      widget.subName,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Subject Code:",
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  Text(
                    widget.subCode,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
