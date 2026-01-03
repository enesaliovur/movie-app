import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:boby_ai_case/data/datasources/account/i_account_data_source.dart';
import 'package:boby_ai_case/data/mappers/movie_mapper.dart';
import 'package:boby_ai_case/domain/entities/account/account_entity.dart';
import 'package:boby_ai_case/domain/entities/movie/paginated_movies_entity.dart';
import 'package:boby_ai_case/domain/repositories/account/i_account_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:boby_ai_case/core/network/mixin/http_failure_handler.dart';

class AccountRepositoryImpl
    with HttpFailureHandlerMixin
    implements IAccountRepository {
  AccountRepositoryImpl(this._dataSource, this._httpFailureHandler);
  final IAccountDataSource _dataSource;
  final HttpFailureHandler _httpFailureHandler;

  @override
  HttpFailureHandler get httpFailureHandler => _httpFailureHandler;

  @override
  Future<FailureOr<AccountEntity>> getAccountDetails() async {
    try {
      final result = await _dataSource.getAccountDetails();
      return right(result.toEntity());
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }

  @override
  Future<FailureOr<Unit>> addFavorite({required int movieId}) async {
    try {
      final result = await _dataSource.addFavorite(movieId: movieId);
      return right(result);
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }

  @override
  Future<FailureOr<Unit>> removeFavorite({required int movieId}) async {
    try {
      final result = await _dataSource.removeFavorite(movieId: movieId);
      return right(result);
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }

  @override
  Future<FailureOr<PaginatedMoviesEntity>> getFavorites() async {
    try {
      final result = await _dataSource.getFavorites();
      return right(MovieMapper.toPaginatedEntity(result));
    } catch (e) {
      return left(handleErrorsAndExceptions(e));
    }
  }
}
