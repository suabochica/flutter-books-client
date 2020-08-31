import 'package:flutter/material.dart';

import '../model/book_model.dart';
import '../network/book_client.dart';

class CreateBookScreen extends StatefulWidget {
  @override
  _CreateBookScreen createState() {
    return _CreateBookScreen();
  }
}

class _CreateBookScreen extends State<CreateBookScreen> {
  final TextEditingController _controller = TextEditingController();
  final BookClient _bookClient = BookClient();

  Future<Book> _futureBook;

  // POST Render
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Create Book Example',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Create Book Example'),
            ),
            body: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: (_futureBook == null)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextField(
                            controller: _controller,
                            decoration:
                                InputDecoration(hintText: 'Enter Title'),
                          ),
                          RaisedButton(
                            child: Text('Create Book'),
                            onPressed: () {
                              setState(() {
                                _futureBook = _bookClient.createBook(
                                    _controller.text, 'Egan Bernal', 2000);
                              });
                            },
                          )
                        ],
                      )
                    : FutureBuilder<Book>(
                        future: _futureBook,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data.title);
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return CircularProgressIndicator();
                        },
                      ))));
  }
}
