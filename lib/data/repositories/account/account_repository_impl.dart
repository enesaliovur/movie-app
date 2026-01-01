import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:boby_ai_case/data/datasources/account/i_account_data_source.dart';
import 'package:boby_ai_case/data/mappers/movie_mapper.dart';
import 'package:boby_ai_case/data/models/account/account.dart';
import 'package:boby_ai_case/domain/entities/movie/paginated_movies_entity.dart';
import 'package:boby_ai_case/domain/repositories/account/i_account_repository.dart';
import 'package:dartz/dartz.dart';

class AccountRepositoryImpl implements IAccountRepository {
  AccountRepositoryImpl(this._dataSource);
  final IAccountDataSource _dataSource;

  @override
  Future<FailureOr<Account>> getAccountDetails() async {
    return _dataSource.getAccountDetails();
  }

  @override
  Future<FailureOr<Unit>> addFavorite({required int movieId}) async {
    return _dataSource.addFavorite(movieId: movieId);
  }

  @override
  Future<FailureOr<Unit>> removeFavorite({required int movieId}) async {
    return _dataSource.removeFavorite(movieId: movieId);
  }

  @override
  Future<FailureOr<PaginatedMoviesEntity>> getFavorites() async {
    final result = await _dataSource.getFavorites();
    return result.fold(
      (failure) => left(failure),
      (data) => right(MovieMapper.toPaginatedEntity(data)),
    );
  }
}
