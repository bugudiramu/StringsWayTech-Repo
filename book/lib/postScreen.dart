import 'package:book/blocs/postProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostHomePage extends StatefulWidget {
  @override
  _PostHomePageState createState() => _PostHomePageState();
}

class _PostHomePageState extends State<PostHomePage> {
  void initState() {
    super.initState();
  }

// Display Snackbar
  // void get _displaySnackbar {
  //   _key.currentState.showSnackBar(SnackBar(
  //       // duration: Duration(minutes: 1),
  //       content: Text('${Provider.of<PostBloc>(context).postId} is deleted')));
  // }

  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final PostBloc postBloc = Provider.of<PostBloc>(context);
    postBloc.getPost();
    return Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text("Posts"),
        ),
        body: postBloc.listPost != null
            ? ListView.builder(
                itemCount: postBloc.listPost.length,
                itemBuilder: (_, int i) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 32.0, horizontal: 16.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            postBloc.listPost[i].title[0]
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        title: Text(
                          postBloc.listPost[i].title.toString(),
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            postBloc.deletePost(i);
                            Future.delayed(Duration(seconds: 1)).then(
                              (_) => _key.currentState.showSnackBar(
                                SnackBar(
                                  // duration: Duration(minutes: 1),
                                  content: Text('Item $i is deleted'),
                                ),
                              ),
                            );

                            // Scaffold.of(context).showSnackBar(SnackBar(
                            //   content: Text("Item deleted."),
                            // ),);

                            // _key.currentState.showSnackBar(
                            //   SnackBar(
                            //     content: Text("Item deleted"),
                            //   ),
                            // );
                          },
                        ),
                      ),
                    ),
                  );
                })
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}

/*
import 'package:book/blocs/postProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostHomePage extends StatefulWidget {
  @override
  _PostHomePageState createState() => _PostHomePageState();
}

class _PostHomePageState extends State<PostHomePage> {
  @override
  Widget build(BuildContext context) {
    final  _postBloc = Provider.of<PostBloc>(context);
    // Future.delayed(Duration(seconds: 4));
    // postBloc.getPost();
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: Consumer<PostBloc>(
        builder: (context, postbloc, _) {
          if (_postBloc.status == Status.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (_postBloc.status == Status.none) {
            return ListView.builder(
              itemCount: _postBloc.listPost.length,
              itemBuilder: (_, int i) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32.0, horizontal: 16.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          _postBloc.listPost[i].title[0]
                              .toString()
                              .toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      title: Text(
                        _postBloc.listPost[i].title.toString(),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            );
          } else
            return Center(child: Text('There was an error'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _postBloc.getPost(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
*/
