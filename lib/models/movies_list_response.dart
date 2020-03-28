import 'package:credicxo/models/movie.dart';

class MoviesListResponse {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<Movie> results;

  MoviesListResponse({
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
  });

  factory MoviesListResponse.fromJson(Map<String, dynamic> json) =>
      MoviesListResponse(
        page: json["page"] == null ? null : json["page"],
        totalResults:
            json["total_results"] == null ? null : json["total_results"],
        totalPages: json["total_pages"] == null ? null : json["total_pages"],
        results: json["results"] == null
            ? null
            : List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page == null ? null : page,
        "total_results": totalResults == null ? null : totalResults,
        "total_pages": totalPages == null ? null : totalPages,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
