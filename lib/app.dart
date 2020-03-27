import 'package:credicxo/pages/movies_list_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credicxo',
      home: MoviesListPage(),
    );
  }
}
