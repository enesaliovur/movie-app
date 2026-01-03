import 'package:boby_ai_case/data/models/account/account_model.dart';
import 'package:boby_ai_case/data/models/movie/movie_information_model.dart';
import 'package:dartz/dartz.dart';

abstract class IAccountDataSource {
  Future<AccountModel> getAccountDetails();
  Future<Unit> addFavorite({required int movieId});
  Future<Unit> removeFavorite({required int movieId});
  Future<MovieInformationModel> getFavorites();
}
