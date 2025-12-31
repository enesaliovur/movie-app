class EndpointConstants {
  // Movie endpoints
  static const String popularMovies = 'movie/popular';
  static const String genres = 'genre/movie/list';
  static const String searchMovies = 'search/movie';
  static String recommendations(int movieId) {
    return 'movie/$movieId/recommendations';
  }

  // Account endpoints
  static const String accountDetails = 'account';
  static String favorite(String? accountId) => 'account/$accountId/favorite';
  static String favoriteMovies(String? accountId) =>
      'account/$accountId/favorite/movies';
}
