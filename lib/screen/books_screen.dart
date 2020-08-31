import 'package:flutter/material.dart';

import '../model/book_model.dart';
import '../network/book_client.dart';

class BooksScreen extends StatelessWidget {
  final BookClient _bookClient = BookClient();
  Future<Book> _futureBook;

  // GET Render
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Get Books Example',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Get Books Example'),
            ),
            body: Center(
              child: FutureBuilder<List<Book>>(
                  future: _bookClient.getAllBooks(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Book> books = snapshot.data;
                      return ListView(
                        children: books
                            .map((Book book) => ListTile(
                                  title: Text(book.title),
                                ))
                            .toList(),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  }),
            )));
  }
}
