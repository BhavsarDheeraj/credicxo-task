import 'package:credicxo/constants/urls.dart';
import 'package:credicxo/models/movie.dart';
import 'package:credicxo/models/movies_list_response.dart';
import 'package:credicxo/service/network_service.dart';

class MoviesRepository {
  Future<List<Movie>> getMovies() async {
    final moviesListResponseJSON = await NetworkService().get(URLs().popular);
    return MoviesListResponse.fromJson(moviesListResponseJSON).results;
  }

  Future<Movie> getDetails(int id) async {
    final movieResponseJSON = await NetworkService().get(URLs().details(id));
    return Movie.fromJson(movieResponseJSON);
  }

  Future<List<Movie>> searchMovies(String term) async {
    final moviesListResponseJSON =
        await NetworkService().get(URLs().search(term));
    return MoviesListResponse.fromJson(moviesListResponseJSON).results;
  }
}
