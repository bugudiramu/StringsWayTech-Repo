import 'dart:convert';

import 'package:book/model/postModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostBloc extends ChangeNotifier {
  List<Post> _post;
  List<Post> get listPost => _post;

  set listPost(List<Post> post) {
    _post = post;
    notifyListeners();
  }

  int _id = 0;

  int get postId => _id;
  set postId(int val) {
    _id = val;
    notifyListeners();
  }

  deletePost(_id) {
    listPost.removeAt(_id);
    notifyListeners();
  }

  Future<List<Post>> getPost() async {
    String url = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var jsonData = json.decode(response.body);
    List<Post> posts = [];
    for (var p in jsonData) {
      Post post = Post(p['id'], p['title'], p['body']);
      posts.add(post);
    }
    listPost = posts;
    // print(listPost.length);
    return listPost;
  }
}

/*
import 'dart:convert';

import 'package:book/model/postModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum Status { loading, none, error }

class PostBloc extends ChangeNotifier {
  PostBloc({
    getPosts(),
  });
  List<Post> _post;
  List<Post> get listPost => _post;

  set listPost(List<Post> post) {
    _post = post;
    notifyListeners();
  }

  Status _status = Status.loading;
  Status get status => _status;

  changeStatus(Status state) {
    _status = state;
    notifyListeners();
  }

  Future<List<Post>> getPost() async {
    changeStatus(Status.loading);
    String url = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Post> posts = [];
      for (var p in jsonData) {
        Post post = Post(p['id'], p['title'], p['body']);
        posts.add(post);
      }
      listPost = posts;

      changeStatus(Status.none);
    } else {
      print('failed getting the data');
      changeStatus(Status.error);
    }
    return listPost;
  }
}
*/
