import 'dart:convert';
import 'package:book/model/postModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostBloc extends ChangeNotifier {
  PostBloc() {
    getPost();
  }
  List<Posts> _post;
  List<Posts> get listPost => _post;

  set listPost(List<Posts> post) {
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

  Future<List<Posts>> getPost() async {
    String url = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      List<Posts> posts = [];
      for (var p in jsonData) {
        Posts post = Posts(p['id'], p['title'], p['body']);
        posts.add(post);
      }
      listPost = posts;
      return listPost;
    } else {
      throw Exception("Failed to Fetch the post");
    }
  }

  Future<Post> createPost(Map<String, dynamic> params) async {
    String url = "https://jsonplaceholder.typicode.com/posts}";
    http.Response response = await http.put(Uri.encodeFull(url),
        headers: {"Accept": "application/json"}, body: params);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      return Post.fromJson(jsonData);
    } else {
      throw Exception("Failed to Create the post");
    }
  }

  Future<Post> updatePost(Posts data) async {
    String url = "https://jsonplaceholder.typicode.com/posts/${data.id}";
    http.Response response = await http
        .put(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      return Post.fromJson(jsonData);
    } else {
      throw Exception("Failed to Update the post");
    }
  }

  Future<Post> deleteThePost(int id) async {
    String url = "https://jsonplaceholder.typicode.com/posts/$id";
    http.Response response = await http
        .delete(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return Post.fromJson(jsonData);
    } else {
      throw Exception("Failed to Delete the post");
    }
  }
}
