import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../model/book_model.dart';
import '../network/book_client.dart';

class DeleteBookScreen extends StatefulWidget {
  @override
  _DeleteBookScreen createState() {
    return _DeleteBookScreen();
  }
}

class _DeleteBookScreen extends State<DeleteBookScreen> {
  final BookClient _bookClient = BookClient();
  Future<Book> _futureBook;
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
            future: _futureBook,
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
                            _futureBook = _bookClient
                                .deleteBook(snapshot.data.id.toString());
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
