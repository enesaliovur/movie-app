import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:boby_ai_case/core/network/mixin/http_failure_handler.dart';
import 'package:boby_ai_case/data/datasources/movie/i_movie_data_source.dart';
import 'package:boby_ai_case/data/mappers/movie_mapper.dart';
import 'package:boby_ai_case/domain/entities/movie/movie_genre_entity.dart';
import 'package:boby_ai_case/domain/entities/movie/paginated_movies_entity.dart';
import 'package:boby_ai_case/domain/repositories/movie/i_movie_repository.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl
    with HttpFailureHandlerMixin
    implements IMovieRepository {
  const MovieRepositoryImpl(this._dataSource, this._httpFailureHandler);
  final IMovieDataSource _dataSource;
  final HttpFailureHandler _httpFailureHandler;

  @override
  HttpFailureHandler get httpFailureHandler => _httpFailureHandler;

  @override
  Future<FailureOr<PaginatedMoviesEntity>> getMovies({int page = 1}) async {
    try {
      final result = await _dataSource.getMovies(page: page);
      return result.fold(
        (failure) => left(failure),
        (data) => right(MovieMapper.toPaginatedEntity(data)),
      );
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }

  @override
  Future<FailureOr<List<MovieGenreEntity>>> getGenres() async {
    try {
      final result = await _dataSource.getGenres();
      return result.fold(
        (failure) => left(failure),
        (data) => right(MovieMapper.toGenreEntityList(data)),
      );
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }

  @override
  Future<FailureOr<PaginatedMoviesEntity>> getRecommendations({
    required int movieId,
  }) async {
    try {
      final result = await _dataSource.getRecommendations(movieId: movieId);
      return result.fold(
        (failure) => left(failure),
        (data) => right(MovieMapper.toPaginatedEntity(data)),
      );
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }

  @override
  Future<FailureOr<PaginatedMoviesEntity>> searchMovies({
    required String query,
    int page = 1,
  }) async {
    try {
      final result = await _dataSource.searchMovies(query: query, page: page);
      return result.fold(
        (failure) => left(failure),
        (data) => right(MovieMapper.toPaginatedEntity(data)),
      );
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }
}
