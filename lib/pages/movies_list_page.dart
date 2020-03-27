import 'package:credicxo/widgets/movies_list.dart';
import 'package:flutter/material.dart';

class MoviesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
      body: MoviesList(),
    );
  }
}
