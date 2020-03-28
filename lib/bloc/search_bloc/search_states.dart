import 'package:credicxo/models/movie.dart';
import 'package:flutter/foundation.dart';

abstract class SearchStates {}

class Initial extends SearchStates {}

class Empty extends SearchStates {}

class Loading extends SearchStates {
  final String message;

  Loading({@required this.message});
}

class Success extends SearchStates {
  final List<Movie> movies;

  Success({@required this.movies});
}

class NoResults extends SearchStates {}

class Error extends SearchStates {
  final String message;

  Error({@required this.message});
}
