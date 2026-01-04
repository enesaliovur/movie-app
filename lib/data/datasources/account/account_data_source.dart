import 'package:boby_ai_case/core/constants/endpoint_constants.dart';
import 'package:boby_ai_case/core/network/client.dart';
import 'package:boby_ai_case/core/network/utilities/response_decoder.dart';
import 'package:boby_ai_case/data/datasources/account/i_account_data_source.dart';
import 'package:boby_ai_case/data/models/account/account_model.dart';
import 'package:boby_ai_case/data/models/movie/movie_information_model.dart';
import 'package:boby_ai_case/data/adapters/movie_api_v2_adapter.dart';
import 'package:dartz/dartz.dart';

class UserDataSource implements IAccountDataSource {
  UserDataSource(this._client);
  final Client _client;

  @override
  Future<AccountModel> getAccountDetails() async {
    final response = await _client.get(EndpointConstants.accountDetails);
    final decodedData = decodeResponseData(response.data);

    if (decodedData is! Map<String, dynamic>) {
      throw const FormatException('Expected Map<String, dynamic>');
    }

    return AccountModel.fromMap(decodedData);
  }

  @override
  Future<Unit> addFavorite({required int movieId}) async {
    final body = {'media_type': 'movie', 'media_id': movieId, 'favorite': true};

    await _client.post(EndpointConstants.favorite(null), data: body);

    return unit;
  }

  @override
  Future<Unit> removeFavorite({required int movieId}) async {
    final body = {
      'media_type': 'movie',
      'media_id': movieId,
      'favorite': false,
    };

    await _client.post(EndpointConstants.favorite(null), data: body);

    return unit;
  }

  @override
  Future<MovieInformationModel> getFavorites() async {
    final response = await _client.get(EndpointConstants.favoriteMovies(null));
    final decodedData = decodeResponseData(response.data);

    if (decodedData is! Map<String, dynamic>) {
      throw const FormatException('Expected Map<String, dynamic>');
    }

    // Simulate V2 Transformation
    final v2Data = transformToV2(decodedData);
    return MovieInformationModel.fromMap(v2Data);
  }
}
