import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:boby_ai_case/core/network/mixin/http_failure_handler.dart';
import 'package:boby_ai_case/data/datasources/movie/movie_data_source.dart';
import 'package:boby_ai_case/data/models/movie/movie_genre_data.dart';
import 'package:boby_ai_case/data/models/movie/movie_information_data.dart';
import 'package:boby_ai_case/domain/repositories/movie/i_movie_repository.dart';
import 'package:dartz/dartz.dart';

class MovieRepository with HttpFailureHandlerMixin implements IMovieRepository {
  const MovieRepository(this._dataSource, this._httpFailureHandler);
  final IMovieDataSource _dataSource;
  final HttpFailureHandler _httpFailureHandler;

  @override
  HttpFailureHandler get httpFailureHandler => _httpFailureHandler;

  @override
  Future<FailureOr<MovieInformationData>> getMovies({int page = 1}) async {
    try {
      final result = await _dataSource.getMovies(page: page);
      return result;
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }

  @override
  Future<FailureOr<List<MovieGenreData>>> getGenres() async {
    try {
      final result = await _dataSource.getGenres();
      return result;
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }

  @override
  Future<FailureOr<MovieInformationData>> getRecommendations(
    int movieId,
  ) async {
    try {
      final result = await _dataSource.getRecommendations(movieId);
      return result;
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }

  @override
  Future<FailureOr<MovieInformationData>> searchMovies(String query) async {
    try {
      final result = await _dataSource.searchMovies(query);
      return result;
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }
}
