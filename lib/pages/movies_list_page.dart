import 'package:credicxo/bloc/movies_list_bloc/movies_list_bloc.dart';
import 'package:credicxo/bloc/movies_list_bloc/movies_list_events.dart';
import 'package:credicxo/bloc/movies_list_bloc/movies_list_states.dart';
import 'package:credicxo/pages/search_page.dart';
import 'package:credicxo/repositories/movies_repository.dart';
import 'package:credicxo/widgets/error_page.dart';
import 'package:credicxo/widgets/loading_indicator.dart';
import 'package:credicxo/widgets/movies_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesListPage extends StatefulWidget {
  @override
  _MoviesListPageState createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  MoviesListBloc moviesListBloc;
  MoviesRepository moviesRepository;

  @override
  void initState() {
    super.initState();
    moviesRepository = MoviesRepository();
    moviesListBloc = MoviesListBloc(
      moviesRepository: moviesRepository,
    );
    moviesListBloc.add(
      GetPopular(),
    );
  }

  @override
  void dispose() {
    moviesListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('Popular'),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: goToSearch),
        ],
        centerTitle: false,
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => moviesListBloc,
          child: buildMoviesList(context),
        ),
      ),
    );
  }

  Widget buildMoviesList(BuildContext context) {
    return BlocBuilder(
      bloc: moviesListBloc,
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
          return MoviesList(
            moviesRepository: moviesRepository,
            movies: (state as Success).movies,
          );
        }
      },
    );
  }

  void onRetry() {
    moviesListBloc.add(GetPopular());
  }

  void goToSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(
          moviesRepository: moviesRepository,
        ),
      ),
    );
  }
}
