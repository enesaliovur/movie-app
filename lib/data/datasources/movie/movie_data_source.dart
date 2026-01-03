import 'package:boby_ai_case/core/constants/endpoint_constants.dart';
import 'package:boby_ai_case/core/network/client.dart';
import 'package:boby_ai_case/core/network/utilities/response_decoder.dart';
import 'package:boby_ai_case/data/datasources/movie/i_movie_data_source.dart';
import 'package:boby_ai_case/data/models/movie/movie_genre_model.dart';
import 'package:boby_ai_case/data/models/movie/movie_information_model.dart';

class MovieDataSource extends IMovieDataSource {
  MovieDataSource(this._client);
  final Client _client;

  @override
  Future<MovieInformationModel> getMovies({int page = 1}) async {
    final response = await _client.get(
      EndpointConstants.popularMovies,
      queryParameters: {'page': page},
    );
    final decodedData = decodeResponseData(response.data);

    if (decodedData is! Map<String, dynamic>) {
      throw const FormatException('Expected Map<String, dynamic>');
    }

    return MovieInformationModel.fromMap(decodedData);
  }

  @override
  Future<List<MovieGenreModel>> getGenres() async {
    final response = await _client.get(EndpointConstants.genres);
    final decodedData = decodeResponseData(response.data);

    if (decodedData is! Map<String, dynamic>) {
      throw const FormatException('Expected Map<String, dynamic>');
    }

    return (response.data['genres'] as List)
        .map((e) => MovieGenreModel.fromMap(e))
        .toList();
  }

  @override
  Future<MovieInformationModel> getRecommendations({
    required int movieId,
  }) async {
    final response = await _client.get(
      EndpointConstants.recommendations(movieId),
    );
    final decodedData = decodeResponseData(response.data);

    if (decodedData is! Map<String, dynamic>) {
      throw const FormatException('Expected Map<String, dynamic>');
    }

    return MovieInformationModel.fromMap(decodedData);
  }

  @override
  Future<MovieInformationModel> searchMovies({
    required String query,
    int page = 1,
  }) async {
    final response = await _client.get(
      EndpointConstants.searchMovies,
      queryParameters: {'query': query, 'page': page},
    );
    final decodedData = decodeResponseData(response.data);

    if (decodedData is! Map<String, dynamic>) {
      throw const FormatException('Expected Map<String, dynamic>');
    }

    return MovieInformationModel.fromMap(decodedData);
  }
}
