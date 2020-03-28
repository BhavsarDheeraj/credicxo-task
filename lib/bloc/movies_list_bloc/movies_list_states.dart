import 'package:credicxo/models/movie.dart';
import 'package:flutter/foundation.dart';

abstract class MoviesListStates {}

class Initial extends MoviesListStates {}

class Loading extends MoviesListStates {
  final String message;

  Loading({@required this.message});
}

class Success extends MoviesListStates {
  final List<Movie> movies;

  Success({@required this.movies});
}

class Error extends MoviesListStates {
  final String message;

  Error({@required this.message});
}
