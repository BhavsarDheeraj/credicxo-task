import 'package:credicxo/bloc/movie_bloc/movie_events.dart';
import 'package:credicxo/bloc/movie_bloc/movie_states.dart';
import 'package:credicxo/repositories/movies_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBloc extends Bloc<MovieEvents, MovieStates> {
  final MoviesRepository moviesRepository;

  MovieBloc({@required this.moviesRepository});

  @override
  MovieStates get initialState => Initial();

  @override
  Stream<MovieStates> mapEventToState(MovieEvents event) async* {
    if (event is GetDetails) {
      yield* mapGetDetailsEventToState(event);
    }
  }

  Stream<MovieStates> mapGetDetailsEventToState(GetDetails event) async* {
    yield Loading(message: 'Getting details');
    try {
      final movie = await moviesRepository.getDetails(event.id);
      yield Success(movie: movie);
    } catch (error) {
      yield Error(message: error.message ?? 'Something went wrong.');
    }
  }
}
