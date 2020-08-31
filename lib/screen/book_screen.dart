import 'package:flutter/material.dart';

import '../model/book_model.dart';
import '../network/book_client.dart';

class BookScreen extends StatelessWidget {
  final BookClient _bookClient = BookClient();
  Future<Book> _futureBook;

  // GET Render
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
                  future: _bookClient.getBookById(),
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
