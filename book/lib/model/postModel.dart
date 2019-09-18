class Posts {
  int id;
  String title;
  String body;

  Posts(this.id, this.title, this.body);
  Posts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
}

class Post {
  int id;
  String title;
  String body;
  //Constructor
  Post({this.id, this.title, this.body});
  //Do the same as Todo
  factory Post.fromJson(Map<String, dynamic> json) {
    Post newPost = Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
    return newPost;
  }
  //clone a Task, or "copy constructor"
  factory Post.fromTask(Post anotherPost) {
    return Post(
      id: anotherPost.id,
      title: anotherPost.title,
      body: anotherPost.body,
    );
  }
}
