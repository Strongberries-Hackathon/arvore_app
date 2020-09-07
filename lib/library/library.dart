import 'dart:core';
import 'package:arvore_app/util/client_api.dart';
import 'package:flutter/material.dart';

import 'book.dart';

class LibraryPage extends StatefulWidget {
  @override
  _LibraryPageState createState() => _LibraryPageState();
}

Map<int, Color> color = {
  50: Color.fromRGBO(177, 208, 174, .1),
  100: Color.fromRGBO(177, 208, 174, .2),
  200: Color.fromRGBO(177, 208, 174, .3),
  300: Color.fromRGBO(177, 208, 174, .4),
  400: Color.fromRGBO(177, 208, 174, .5),
  500: Color.fromRGBO(177, 208, 174, .6),
  600: Color.fromRGBO(177, 208, 174, .7),
  700: Color.fromRGBO(177, 208, 174, .8),
  800: Color.fromRGBO(177, 208, 174, .9),
  900: Color.fromRGBO(177, 208, 174, 1),
};

MaterialColor colorCustom = MaterialColor(0xFFB1D0AE, color);

class _LibraryPageState extends State<LibraryPage> {
  List<Book> _books = [];
  Api _api = Api();

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
                child: _books == null
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        itemCount: _books.length,
                        itemBuilder: (BuildContext context, int index) {
                          Book book = _books[index];
                          return Card(
                            elevation: 5,
                            child: Container(
                              height: 150.0,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 150.0,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            topLeft: Radius.circular(5)),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                NetworkImage("${book.cover}"))),
                                  ),
                                  Container(
                                    height: 100,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("${book.title}",
                                              style: TextStyle(
                                                color: Color(0xFF619D5C),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                fontFamily: 'Quicksand',
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text("${book.resume}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  fontFamily: 'Quicksand',
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ))));
  }

  void getBooks() async {
    var result = await _api.http_get("book");
    if (result.ok) {
      setState(() {
        var in_books = result.data as List<dynamic>;
        in_books.forEach((in_book) {
          _books.add(Book(
            in_book['id'],
            in_book['title'],
            in_book['resume'],
            in_book['author'],
            in_book['cover'],
            in_book['page'],
          ));
        });
      });
    }
  }
}
