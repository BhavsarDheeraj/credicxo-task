import 'package:credicxo/bloc/search_bloc/search_events.dart';
import 'package:credicxo/bloc/search_bloc/search_states.dart';
import 'package:credicxo/repositories/movies_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvents, SearchStates> {
  final MoviesRepository moviesRepository;

  SearchBloc({@required this.moviesRepository});

  @override
  SearchStates get initialState => Initial();

  @override
  Stream<SearchStates> mapEventToState(SearchEvents event) async* {
    if (event is SearchMovies) {
      yield* mapSearchMovieEventToState(event);
    }
  }

  Stream<SearchStates> mapSearchMovieEventToState(SearchMovies event) async* {
    if (event.term.isEmpty) {
      yield Empty();
    } else {
      yield Loading(message: 'Searching');
      try {
        final movies = await moviesRepository.searchMovies(event.term);
        yield movies.length > 0 ? Success(movies: movies) : NoResults();
      } catch (error) {
        yield Error(message: error.message ?? 'Something went wrong');
      }
    }
  }
}
