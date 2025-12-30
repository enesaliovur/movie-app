import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:boby_ai_case/data/models/movie/movie_data.dart';
import 'package:boby_ai_case/data/models/movie/movie_genre_data.dart';
import 'package:boby_ai_case/data/models/movie/movie_information_data.dart';
import 'package:boby_ai_case/domain/repositories/movie/i_movie_repository.dart';
import 'package:mobx/mobx.dart';

part 'movie_store.g.dart';

class MovieStore = _MovieStore with _$MovieStore;

abstract class _MovieStore with Store {
  _MovieStore(this._repository);
  final IMovieRepository _repository;

  @observable
  bool isLoading = false;

  @observable
  Failure? failure;

  @observable
  MovieInformationData movieInformation = MovieInformationData.empty();

  @observable
  List<MovieGenreData> genres = [];

  @observable
  MovieInformationData recommendations = MovieInformationData.empty();

  @observable
  MovieInformationData searchResults = MovieInformationData.empty();

  @observable
  String searchQuery = '';

  @computed
  List<MovieData> get movies => movieInformation.movies;

  @computed
  bool get hasMorePages => movieInformation.page < movieInformation.totalPages;

  @computed
  bool get hasError => failure != null;

  @action
  Future<void> getMovies({int page = 1, bool loadMore = false}) async {
    if (isLoading) return;

    isLoading = true;
    failure = null;

    final result = await _repository.getMovies(page: page);

    result.fold((error) => failure = error, (data) {
      if (loadMore) {
        movieInformation = MovieInformationData(
          movies: [...movieInformation.movies, ...data.movies],
          page: data.page,
          totalPages: data.totalPages,
        );
      } else {
        movieInformation = data;
      }
    });

    isLoading = false;
  }

  @action
  Future<void> getGenres() async {
    final result = await _repository.getGenres();
    result.fold((error) => failure = error, (data) => genres = data);
  }

  @action
  Future<void> getRecommendations(int movieId) async {
    isLoading = true;
    failure = null;

    final result = await _repository.getRecommendations(movieId);

    result.fold((error) => failure = error, (data) => recommendations = data);

    isLoading = false;
  }

  @action
  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      searchResults = MovieInformationData.empty();
      searchQuery = '';
      return;
    }

    isLoading = true;
    failure = null;
    searchQuery = query;

    final result = await _repository.searchMovies(query);

    result.fold((error) => failure = error, (data) => searchResults = data);

    isLoading = false;
  }

  @action
  void clearSearch() {
    searchResults = MovieInformationData.empty();
    searchQuery = '';
  }

  @action
  void clearFailure() {
    failure = null;
  }
}
