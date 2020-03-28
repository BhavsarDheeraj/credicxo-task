import 'package:credicxo/bloc/search_bloc/search_bloc.dart';
import 'package:credicxo/bloc/search_bloc/search_events.dart';
import 'package:credicxo/bloc/search_bloc/search_states.dart';
import 'package:credicxo/repositories/movies_repository.dart';
import 'package:credicxo/widgets/error_page.dart';
import 'package:credicxo/widgets/loading_indicator.dart';
import 'package:credicxo/widgets/search_movies_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  final MoviesRepository moviesRepository;

  SearchPage({@required this.moviesRepository});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  MoviesRepository get moviesRepository => widget.moviesRepository;

  SearchBloc searchBloc;

  @override
  void initState() {
    super.initState();
    searchBloc = SearchBloc(moviesRepository: moviesRepository);
  }

  @override
  void dispose() {
    searchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Card(
        color: Colors.white10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search movies',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
          ),
          cursorColor: Colors.yellow,
          textInputAction: TextInputAction.search,
          onSubmitted: onSubmit,
          onChanged: onChange,
        ),
      ),
    );
  }

  Widget buildBody() {
    return BlocBuilder(
      bloc: searchBloc,
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
          );
        } else if (state is Empty) {
          return Container();
        } else if (state is NoResults) {
          return Container(
            child: Center(
              child: Text(
                'No movies found.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
          );
        } else {
          return SearchMoviesList(
            moviesRepository: moviesRepository,
            movies: (state as Success).movies,
          );
        }
      },
    );
  }

  void onSubmit(String term) {
    FocusScope.of(context).unfocus();
    if (term.isNotEmpty) {
      searchBloc.add(SearchMovies(term: term));
    }
  }

  void onChange(String str) {
    if (str.isEmpty) {
      searchBloc.add(SearchMovies(term: ''));
    }
  }
}
