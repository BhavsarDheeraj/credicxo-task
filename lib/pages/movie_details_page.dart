import 'package:credicxo/bloc/movie_bloc/movie_bloc.dart';
import 'package:credicxo/bloc/movie_bloc/movie_events.dart';
import 'package:credicxo/bloc/movie_bloc/movie_states.dart';
import 'package:credicxo/repositories/movies_repository.dart';
import 'package:credicxo/widgets/error_page.dart';
import 'package:credicxo/widgets/loading_indicator.dart';
import 'package:credicxo/widgets/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailsPage extends StatefulWidget {
  final MoviesRepository moviesRepository;
  final int id;

  MovieDetailsPage({@required this.id, @required this.moviesRepository});

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MoviesRepository get moviesRepository => widget.moviesRepository;

  MovieBloc movieBloc;

  @override
  void initState() {
    super.initState();
    movieBloc = MovieBloc(moviesRepository: moviesRepository);
    movieBloc.add(GetDetails(id: widget.id));
  }

  @override
  void dispose() {
    movieBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocBuilder(
          bloc: movieBloc,
          builder: (context, state) {
            if (state is Initial) {
              return Container();
            } else if (state is Loading) {
              return Container(
                child: Center(
                  child: LoadingIndicator(),
                ),
              );
            } else if (state is Error) {
              return ErrorPage(
                message: state.message,
                onRetry: onRetry,
              );
            } else {
              return MovieDetails(
                movie: (state as Success).movie,
              );
            }
          },
        ),
      ),
    );
  }

  void onRetry() {
    movieBloc.add(GetDetails(id: widget.id));
  }
}
