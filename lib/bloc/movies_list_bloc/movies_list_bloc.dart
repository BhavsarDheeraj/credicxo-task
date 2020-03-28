import 'package:credicxo/bloc/movies_list_bloc/movies_list_events.dart';
import 'package:credicxo/bloc/movies_list_bloc/movies_list_states.dart';
import 'package:credicxo/repositories/movies_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

class MoviesListBloc extends Bloc<MoviesListEvents, MoviesListStates> {
  final MoviesRepository moviesRepository;

  MoviesListBloc({@required this.moviesRepository});

  @override
  MoviesListStates get initialState => Initial();

  @override
  Stream<MoviesListStates> mapEventToState(MoviesListEvents event) async* {
    if (event is GetPopular) {
      yield* mapGetPopularEventToState(event);
    }
  }

  Stream<MoviesListStates> mapGetPopularEventToState(GetPopular event) async* {
    yield Loading(message: 'Getting popular movies');
    try {
      final movies = await moviesRepository.getMovies();
      yield Success(movies: movies);
    } catch (error) {
      yield Error(message: error.message ?? 'Something went wrong');
    }
  }
}
