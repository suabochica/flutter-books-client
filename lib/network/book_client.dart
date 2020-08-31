import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/book_model.dart';

class BookClient {
  Future<List<Book>> getAllBooks() async {
    http.Response response = await http.get('http://localhost:8888/books');

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Book> books = body
          .map(
            (dynamic item) => Book.fromJson(item),
          )
          .toList();

      return books;
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<Book> getBookById() async {
    final response = await http.get('http://localhost:8888/books/2');

    if (response.statusCode == 200) {
      return Book.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load book');
    }
  }

  Future<Book> createBook(String title, String author, int year) async {
    final http.Response response = await http.post(
      'http://localhost:8888/books',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': title,
        'author': author,
        'year': year,
      }),
    );

    if (response.statusCode == 200) {
      return Book.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create book');
    }
  }

  Future<Book> replaceBook() async {
    final http.Response response = await http.put(
      'http://localhost:8888/books/1',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF=8'
      },
      body: jsonEncode(<String, dynamic>{
        'title': 'REST API Design Rule Book',
        'author': 'Mark Masse',
        'year': 2011,
      }),
    );

    if (response.statusCode == 200) {
      return Book.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to replace book');
    }
  }

  Future<Book> updateBook(String id) async {
    final http.Response response = await http.patch(
      'http://localhost:8888/books/1',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF=8'
      },
      body: jsonEncode(<String, dynamic>{
        'author': 'Sergio Benítez',
      }),
    );

    if (response.statusCode == 200) {
      return Book.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update book');
    }
  }

  Future<Book> deleteBook(String id) async {
    final http.Response response = await http.delete(
      'http://localhost:8888/books/2',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return Book.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete book');
    }
  }
}
