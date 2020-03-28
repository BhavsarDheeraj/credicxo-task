import 'package:credicxo/constants/urls.dart';
import 'package:credicxo/models/movie.dart';
import 'package:credicxo/pages/movie_details_page.dart';
import 'package:credicxo/repositories/movies_repository.dart';
import 'package:flutter/material.dart';

class SearchMoviesList extends StatelessWidget {
  final MoviesRepository moviesRepository;
  final List<Movie> movies;

  SearchMoviesList({@required this.moviesRepository, @required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return buildSearchMovieListTile(movie, context);
      },
      separatorBuilder: (context, _) => Divider(),
    );
  }

  ListTile buildSearchMovieListTile(Movie movie, BuildContext context) {
    return ListTile(
      leading: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: FadeInImage(
          width: 36,
          image: NetworkImage(
            '${URLs().imageURL}${movie.posterPath}',
          ),
          placeholder: AssetImage('assets/images/video-player.png'),
          fit: BoxFit.cover,
        ),
      ),
      title: Text(movie.title),
      onTap: () => goToDetails(context, movie),
    );
  }

  void goToDetails(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MovieDetailsPage(id: movie.id, moviesRepository: moviesRepository),
      ),
    );
  }
}
