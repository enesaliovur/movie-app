class EndpointConstants {
  // Movie endpoints
  static const String popularMovies = 'movie/popular';
  static const String genres = 'genre/movie/list';
  static const String searchMovies = 'search/movie';
  static String recommendations(int movieId) {
    return 'movie/$movieId/recommendations';
  }

  // Account endpoints
  static const String account = '/account';
  static const String favorite = '/account/null/favorite';
  static const String favoriteMovies = '/account/null/favorite/movies';
}
