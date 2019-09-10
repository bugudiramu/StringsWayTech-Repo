import 'package:book/bookDetail.dart';
import 'package:book/model/bookModel.dart';
import 'package:flutter/material.dart';

class Book extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  BookModel bookModel;
  void delay() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        bookModel = BookModel();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    this.delay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookshelf"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: bookModel == null ? 0 : bookModel.book.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetail(
                      image: bookModel.book[index]['image'],
                      subName: bookModel.book[index]['subName'],
                      subCode: bookModel.book[index]['subCode']),
                ),
              );
            },
            child: GridTile(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  bookModel.book[index]['image'],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
