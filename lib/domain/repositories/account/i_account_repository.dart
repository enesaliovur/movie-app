import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:boby_ai_case/domain/entities/account/account_entity.dart';
import 'package:boby_ai_case/domain/entities/movie/paginated_movies_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IAccountRepository {
  Future<FailureOr<AccountEntity>> getAccountDetails();
  Future<FailureOr<Unit>> addFavorite({required int movieId});
  Future<FailureOr<Unit>> removeFavorite({required int movieId});
  Future<FailureOr<PaginatedMoviesEntity>> getFavorites();
}
