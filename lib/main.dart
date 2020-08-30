import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Book> getBookById() async {
  final response = await http.get('http://localhost:8888/books/8');

  if (response.statusCode == 200) {
    return Book.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load books');
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

  if (response.statusCode == 201) {
    return Book.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create book');
  }
}

Future<Book> deleteBook(String id) async {
  final http.Response response = await http.delete(
    'http://localhost:8888/books/8',
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
  // final TextEditingController _controller = TextEditingController();
  Future<Book> futureBook;

  @override
  void initState() {
    super.initState();
    futureBook = getBookById();
  }

  // GET Render
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //       title: 'Get Book Example',
  //       theme: ThemeData(
  //         primarySwatch: Colors.blue,
  //       ),
  //       home: Scaffold(
  //           appBar: AppBar(
  //             title: Text('Get Book Example'),
  //           ),
  //           body: Center(
  //             child: FutureBuilder<Book>(
  //                 future: futureBook,
  //                 builder: (context, snapshot) {
  //                   if (snapshot.hasData) {
  //                     return Text(snapshot.data.title);
  //                   } else if (snapshot.hasError) {
  //                     return Text("${snapshot.error}");
  //                   }
  //                   return CircularProgressIndicator();
  //                 }),
  //           )));
  // }

  // POST Render
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //       title: 'Create Book Example',
  //       theme: ThemeData(
  //         primarySwatch: Colors.blue,
  //       ),
  //       home: Scaffold(
  //           appBar: AppBar(
  //             title: Text('Create Book Example'),
  //           ),
  //           body: Container(
  //               alignment: Alignment.center,
  //               padding: const EdgeInsets.all(8.0),
  //               child: (futureBook == null)
  //                   ? Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: <Widget>[
  //                         TextField(
  //                           controller: _controller,
  //                           decoration:
  //                               InputDecoration(hintText: 'Enter Title'),
  //                         ),
  //                         RaisedButton(
  //                           child: Text('Create Book'),
  //                           onPressed: () {
  //                             setState(() {
  //                               futureBook =
  //                                   createBook(_controller.text, 'Egan', 2000);
  //                             });
  //                           },
  //                         )
  //                       ],
  //                     )
  //                   : FutureBuilder<Book>(
  //                       future: futureBook,
  //                       builder: (context, snapshot) {
  //                         if (snapshot.hasData) {
  //                           return Text(snapshot.data.title);
  //                         } else if (snapshot.hasError) {
  //                           return Text("${snapshot.error}");
  //                         }
  //                         return CircularProgressIndicator();
  //                       },
  //                     ))));
  // }

  // DELETE Render
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delete Data Example',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Delete Data Example')),
        body: Center(
          child: FutureBuilder<Book>(
            future: futureBook,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${snapshot.data?.title ?? 'Deleted'}'),
                      RaisedButton(
                        child: Text('Delete Data'),
                        onPressed: () {
                          setState(() {
                            futureBook =
                                deleteBook(snapshot.data.id.toString());
                          });
                        },
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
