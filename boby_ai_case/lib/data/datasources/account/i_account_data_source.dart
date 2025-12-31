import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:boby_ai_case/data/models/account/account.dart';
import 'package:boby_ai_case/data/models/movie/movie_information_data.dart';
import 'package:dartz/dartz.dart';

abstract class IAccountDataSource {
  Future<FailureOr<Account>> getAccountDetails();
  Future<FailureOr<Unit>> addFavorite({required int movieId});
  Future<FailureOr<Unit>> removeFavorite({required int movieId});
  Future<FailureOr<MovieInformationData>> getFavorites();
}
