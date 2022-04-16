class Comment {
  int id;
  String username;
  String message;
  String date;
  List<Comment>? response;

  Comment(
    this.id,
    this.username,
    this.message,
    this.date,
    this.response,
  );
}
