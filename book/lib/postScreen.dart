import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blocs/postProvider.dart';
import 'model/postModel.dart';

class PostHomePage extends StatefulWidget {
  @override
  _PostHomePageState createState() => _PostHomePageState();
}

class _PostHomePageState extends State<PostHomePage> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // final _formKey = GlobalKey<FormState>();
    // TextEditingController _controller;
    Post post = Post();
    final PostBloc postBloc = Provider.of<PostBloc>(context);
    setState(() {
      post = Post.fromTask(post);
    });
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: postBloc.listPost != null
          ? ListView.builder(
              itemCount: postBloc.listPost.length,
              itemBuilder: (_, int i) {
                return GestureDetector(
                  onTap: () {
                    _showUpdateDialog(post, i);
                  },
                  onLongPress: () {
                    _showDeletePostDialog(post, i);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 32.0, horizontal: 16.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            postBloc.listPost[i].id.toString().toUpperCase(),
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
                          onPressed: () async {
                            postBloc.deletePost(i);
                            // postBloc.deleteThePost(postBloc.listPost[i].id);
                            _key.currentState.showSnackBar(
                              SnackBar(
                                content: Text('Item $i is deleted'),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<void> _showDeletePostDialog(post, index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Do you want to delete the post"),
            actions: <Widget>[
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Delete"),
                onPressed: () {
                  // Provider.of<PostBloc>(context).deleteThePost(index);

                  Provider.of<PostBloc>(context).deletePost(index);
                  _key.currentState.showSnackBar(
                    SnackBar(
                      content: Text("Item deleted at index $index"),
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> _showUpdateDialog(post, index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: TextField(
                      controller: TextEditingController(
                          text: Provider.of<PostBloc>(context)
                              .listPost[index]
                              .title
                              .toString()),
                      onChanged: (text) {
                        setState(() {
                          Provider.of<PostBloc>(context).listPost[index].title =
                              text;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Enter A Post",
                        labelText: "Post",
                        icon: Icon(Icons.event_note),
                      ),
                      autofocus: true,
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Save"),
                onPressed: () async {
                  // Map<String, dynamic> params = Map<String, dynamic>();
                  // params['id'] = post.id;
                  // params['title'] = post.title;
                  // params['body'] = post.body;
                  Navigator.pop(context);
                  await Provider.of<PostBloc>(context).updatePost(index);
                },
              ),
            ],
          );
        });
  }
}
