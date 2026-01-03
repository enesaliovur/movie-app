import 'package:boby_ai_case/data/models/movie/movie_genre_model.dart';
import 'package:boby_ai_case/data/models/movie/movie_information_model.dart';

abstract class IMovieDataSource {
  Future<MovieInformationModel> getMovies({int page = 1});
  Future<List<MovieGenreModel>> getGenres();
  Future<MovieInformationModel> getRecommendations({required int movieId});
  Future<MovieInformationModel> searchMovies({
    required String query,
    int page = 1,
  });
}
