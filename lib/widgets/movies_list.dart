import 'package:credicxo/constants/urls.dart';
import 'package:credicxo/models/movie.dart';
import 'package:credicxo/pages/movie_details_page.dart';
import 'package:credicxo/repositories/movies_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoviesList extends StatelessWidget {
  final MoviesRepository moviesRepository;
  final List<Movie> movies;

  MoviesList({@required this.moviesRepository, @required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Divider(),
      ),
      physics: BouncingScrollPhysics(),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return buildMovieListTile(context, movie);
      },
    );
  }

  Widget buildMovieListTile(BuildContext context, Movie movie) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      child: InkWell(
        onTap: () => goToMovieDetails(context, movie),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: Container(
                child: FadeInImage(
                  image: NetworkImage(
                    '${URLs().imageURL}${movie.posterPath}',
                  ),
                  placeholder: AssetImage('assets/images/video-player.png'),
                  height: 100,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(movie.title),
                subtitle: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Released ${getString(movie.releaseDate)}'),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        movie.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goToMovieDetails(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsPage(
          id: movie.id,
          moviesRepository: moviesRepository,
        ),
      ),
    );
  }

  String getString(DateTime date) {
    var formatter = new DateFormat('MMMM y');
    return formatter.format(date);
  }
}
