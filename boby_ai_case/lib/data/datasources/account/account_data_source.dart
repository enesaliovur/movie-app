import 'package:boby_ai_case/core/constants/endpoint_constants.dart';
import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:boby_ai_case/core/network/client.dart';
import 'package:boby_ai_case/core/network/mixin/http_failure_handler.dart';
import 'package:boby_ai_case/core/network/utilities/response_decoder.dart';
import 'package:boby_ai_case/data/datasources/account/i_account_data_source.dart';
import 'package:boby_ai_case/data/models/account/account.dart';
import 'package:boby_ai_case/data/models/movie/movie_information_data.dart';
import 'package:dartz/dartz.dart';

class UserDataSource
    with HttpFailureHandlerMixin
    implements IAccountDataSource {
  UserDataSource(this._client, this._httpFailureHandler);
  final Client _client;
  final HttpFailureHandler _httpFailureHandler;

  @override
  Future<FailureOr<Account>> getAccountDetails() async {
    try {
      final response = await _client.get(EndpointConstants.accountDetails);
      final decodedData = decodeResponseData(response.data);

      if (decodedData is! Map<String, dynamic>) {
        return left(const TypeFailure());
      }

      final generalFailure = handleResult(
        response.statusCode ?? 0,
        decodedData,
      );
      if (generalFailure != null) return left(generalFailure);

      return right(Account.fromMap(decodedData));
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }

  @override
  Future<FailureOr<Unit>> addFavorite({required int movieId}) async {
    try {
      final body = {
        'media_type': 'movie',
        'media_id': movieId,
        'favorite': true,
      };

      final response = await _client.post(
        EndpointConstants.favorite(null),
        data: body,
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

      return right(unit);
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }

  @override
  Future<FailureOr<Unit>> removeFavorite({required int movieId}) async {
    try {
      final body = {
        'media_type': 'movie',
        'media_id': movieId,
        'favorite': false,
      };

      final response = await _client.post(
        EndpointConstants.favorite(null),
        data: body,
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

      return right(unit);
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }

  @override
  Future<FailureOr<MovieInformationData>> getFavorites() async {
    try {
      final response = await _client.get(
        EndpointConstants.favoriteMovies(null),
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
