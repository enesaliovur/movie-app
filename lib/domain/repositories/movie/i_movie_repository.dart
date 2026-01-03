import 'package:boby_ai_case/domain/entities/movie/movie_genre_entity.dart';
import 'package:boby_ai_case/domain/entities/movie/paginated_movies_entity.dart';
import 'package:boby_ai_case/core/failure/failure.dart';

abstract class IMovieRepository {
  Future<FailureOr<PaginatedMoviesEntity>> getMovies({int page = 1});
  Future<FailureOr<List<MovieGenreEntity>>> getGenres();
  Future<FailureOr<PaginatedMoviesEntity>> getRecommendations({
    required int movieId,
  });
  Future<FailureOr<PaginatedMoviesEntity>> searchMovies({
    required String query,
    int page = 1,
  });
}
