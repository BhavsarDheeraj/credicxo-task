class URLs {
  static final URLs _singleton = URLs._internal();

  factory URLs() {
    return _singleton;
  }

  URLs._internal();

  static final String _apiKey = '2bd7cc5e11eb691e6456f7187f8c8373';

  String base = 'https://api.themoviedb.org/3/movie';
  String popular = '/popular?api_key=$_apiKey';

  String imageURL = 'https://image.tmdb.org/t/p/w500';

  String details(int id) {
    return 'https://api.themoviedb.org/3/movie/$id?api_key=$_apiKey';
  }

  String search(String term) {
    return 'https://api.themoviedb.org/3/search/movie?api_key=$_apiKey&query=$term';
  }
}
