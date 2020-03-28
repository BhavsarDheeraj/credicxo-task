import 'package:credicxo/models/movie.dart';
import 'package:flutter/foundation.dart';

abstract class MovieStates {}

class Initial extends MovieStates {}

class Loading extends MovieStates {
  final String message;

  Loading({@required this.message});
}

class Success extends MovieStates {
  final Movie movie;

  Success({@required this.movie});
}

class Error extends MovieStates {
  final String message;

  Error({@required this.message});
}
