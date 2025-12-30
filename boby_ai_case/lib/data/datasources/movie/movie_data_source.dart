import 'package:boby_ai_case/core/constants/endpoint_constants.dart';
import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:boby_ai_case/core/network/client.dart';
import 'package:boby_ai_case/core/network/mixin/http_failure_handler.dart';
import 'package:boby_ai_case/core/network/utilities/response_decoder.dart';
import 'package:boby_ai_case/data/models/movie/movie_genre_data.dart';
import 'package:boby_ai_case/data/models/movie/movie_information_data.dart';
import 'package:dartz/dartz.dart';

abstract class IMovieDataSource {
  Future<FailureOr<MovieInformationData>> getMovies({int page = 1});
  Future<FailureOr<List<MovieGenreData>>> getGenres();
  Future<FailureOr<MovieInformationData>> getRecommendations(int movieId);
  Future<FailureOr<MovieInformationData>> searchMovies(String query);
}

class MovieDataSource extends IMovieDataSource with HttpFailureHandlerMixin {
  MovieDataSource(this._client, this._httpFailureHandler);
  final Client _client;
  final HttpFailureHandler _httpFailureHandler;

  @override
  Future<FailureOr<MovieInformationData>> getMovies({int page = 1}) async {
    try {
      final response = await _client.get(
        EndpointConstants.popularMovies,
        queryParameters: {'page': page},
      );
      final decodedData = decodeResponseData(response.data);

      if (decodedData is! Map<String, dynamic>) {
        return left(const TypeFailure());
      }

      final generalFailure = handleResult(
        response.statusCode ?? 0,
        decodedData,
      );
      if (generalFailure != null) return left(generalFailure);

      return right(MovieInformationData.fromMap(decodedData));
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }

  @override
  Future<FailureOr<List<MovieGenreData>>> getGenres() async {
    try {
      final response = await _client.get(EndpointConstants.genres);
      final decodedData = decodeResponseData(response.data);

      if (decodedData is! Map<String, dynamic>) {
        return left(const TypeFailure());
      }

      final generalFailure = handleResult(
        response.statusCode ?? 0,
        decodedData,
      );
      if (generalFailure != null) return left(generalFailure);

      return right(
        (response.data['genres'] as List)
            .map((e) => MovieGenreData.fromMap(e))
            .toList(),
      );
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }

  @override
  Future<FailureOr<MovieInformationData>> getRecommendations(
    int movieId,
  ) async {
    try {
      final response = await _client.get(
        EndpointConstants.recommendations(movieId),
      );
      final decodedData = decodeResponseData(response.data);

      if (decodedData is! Map<String, dynamic>) {
        return left(const TypeFailure());
      }

      final generalFailure = handleResult(
        response.statusCode ?? 0,
        decodedData,
      );
      if (generalFailure != null) return left(generalFailure);

      return right(MovieInformationData.fromMap(decodedData));
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }

  @override
  Future<FailureOr<MovieInformationData>> searchMovies(String query) async {
    try {
      final response = await _client.get(
        EndpointConstants.searchMovies,
        queryParameters: {'query': query},
      );
      final decodedData = decodeResponseData(response.data);

      if (decodedData is! Map<String, dynamic>) {
        return left(const TypeFailure());
      }

      final generalFailure = handleResult(
        response.statusCode ?? 0,
        decodedData,
      );
      if (generalFailure != null) return left(generalFailure);

      return right(MovieInformationData.fromMap(decodedData));
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }

  @override
  HttpFailureHandler get httpFailureHandler => _httpFailureHandler;
}
