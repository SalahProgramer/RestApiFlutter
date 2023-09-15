class post1 {
  String userId;
  String title;
  String description;

  post1({required this.userId, required this.title, required this.description});

  factory post1.fromJson(Map<String, dynamic> json) {
    return post1(
        userId: json['userId'].toString(),
        title: json['title'],
        description: json['body']);
  }
}
