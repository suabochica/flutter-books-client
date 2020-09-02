class Book {
  final int id;
  final String title;
  final String author;
  final int year;

  Book({this.id, this.title, this.author, this.year});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['id'],
        title: json['title'],
        author: json['author'],
        year: json['year']);
  }
}
