import 'package:flutter/foundation.dart';

abstract class SearchEvents {}

class SearchMovies extends SearchEvents {
  final String term;

  SearchMovies({@required this.term});
}
