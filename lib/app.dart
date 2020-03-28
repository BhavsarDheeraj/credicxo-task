import 'package:credicxo/pages/movies_list_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credicxo',
      home: MoviesListPage(),
      theme: getTheme(),
    );
  }

  ThemeData getTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.black,
      canvasColor: Colors.black,
      splashColor: Colors.transparent,
      scaffoldBackgroundColor: Colors.black,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      accentColor: Colors.amber,
      accentColorBrightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.yellowAccent),
      dividerColor: Colors.white30,
    );
  }
}
