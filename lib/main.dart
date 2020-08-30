import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Book> getBookById() async {
  final response = await http.get('http://localhost:8888/books/4');

  if (response.statusCode == 200) {
    return Book.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load books');
  }
}

class Book {
  final int id;
  final String title;
  final String author;
  final int year;

  Book({this.id, this.title, this.author, this.year});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['userId'],
        title: json['title'],
        author: json['author'],
        year: json['year']);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Book> futureBook;

  @override
  void initState() {
    super.initState();
    futureBook = getBookById();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Get Book Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Get Book Example'),
            ),
            body: Center(
              child: FutureBuilder<Book>(
                  future: futureBook,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data.title);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  }),
            )));
  }
}
