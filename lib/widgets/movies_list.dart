import 'package:flutter/material.dart';

class MoviesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Movie ${index + 1}'),
          subtitle: Text('Movie ${index + 1} subtitle'),
        );
      },
    );
  }
}
