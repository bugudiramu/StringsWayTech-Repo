class Post {
  int id;
  String title;
  String body;

  Post(this.id, this.title, this.body);
  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
}
