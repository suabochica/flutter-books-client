import 'package:flutter/material.dart';
import 'screen/book_screen.dart';
import 'screen/books_screen.dart';
import 'screen/create_book_screen.dart';
import 'screen/delete_book_screen.dart';

void main() {
  runApp(MyBookApp());
}

class MyBookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: CreateBookScreen());
  }
}
