import 'package:credicxo/constants/urls.dart';
import 'package:credicxo/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovieDetails extends StatelessWidget {
  final Movie movie;

  MovieDetails({@required this.movie});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        buildCover(),
        buildDetails(context),
      ],
    );
  }

  Widget buildDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            movie.title,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          buildRelease(context),
          Divider(),
          buildGenres(context),
          buildVoteDetails(context),
          Divider(),
          buildLanguages(context),
          Divider(),
          buildOverview(context),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget buildRelease(BuildContext context) {
    if (movie.releaseDate != null) {
      return Text(
        'Released on ' + getString(movie.releaseDate),
        style: Theme.of(context).textTheme.subhead,
      );
    } else {
      return Container();
    }
  }

  Widget buildOverview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Storyline',
          style: Theme.of(context).textTheme.title,
        ),
        SizedBox(height: 8),
        Text(
          movie.overview,
          style: Theme.of(context).textTheme.body2,
        ),
      ],
    );
  }

  Widget buildVoteDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Popularity',
          style: Theme.of(context).textTheme.title,
        ),
        Row(
          children: <Widget>[
            Chip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${movie.voteAverage}',
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.star),
                ],
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Chip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(' ${movie.voteCount} Votes'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildLanguages(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Languages',
          style: Theme.of(context).textTheme.title,
        ),
        SizedBox(height: 4),
        Wrap(
          children: movie.spokenLanguages
                  ?.map((l) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Chip(
                            label: Text(l.name),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ))
                  ?.toList() ??
              [],
        ),
      ],
    );
  }

  Widget buildGenres(BuildContext context) {
    if (movie.genres.length == 0) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Genres',
          style: Theme.of(context).textTheme.title,
        ),
        SizedBox(height: 4),
        Wrap(
          children: movie.genres
                  ?.map((g) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Chip(
                            label: Text(g.name),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ))
                  ?.toList() ??
              [],
        ),
        Divider(),
      ],
    );
  }

  Widget buildCover() {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAlias,
        child: FadeInImage(
          image: NetworkImage(
            '${URLs().imageURL}${movie.backdropPath}',
          ),
          placeholder: AssetImage('assets/images/video-player.png'),
          fit: BoxFit.cover,
          height: 240,
        ),
      ),
    );
  }

  String getString(DateTime date) {
    var formatter = new DateFormat('d MMMM y');
    return formatter.format(date);
  }
}
