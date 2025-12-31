import 'package:boby_ai_case/data/models/movie/movie_genre_data.dart';
import 'package:boby_ai_case/data/models/movie/movie_information_data.dart';
import 'package:boby_ai_case/core/failure/failure.dart';

abstract class IMovieRepository {
  Future<FailureOr<MovieInformationData>> getMovies({int page = 1});
  Future<FailureOr<List<MovieGenreData>>> getGenres();
  Future<FailureOr<MovieInformationData>> getRecommendations({
    required int movieId,
  });
  Future<FailureOr<MovieInformationData>> searchMovies({required String query});
}
