import 'dart:math';

import 'package:boby_ai_case/core/cache/cache_key.dart';
import 'package:boby_ai_case/core/cache/i_cache_service.dart';
import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:boby_ai_case/data/models/movie/movie_data.dart';
import 'package:boby_ai_case/data/models/movie/movie_genre_data.dart';
import 'package:boby_ai_case/data/models/movie/movie_information_data.dart';
import 'package:boby_ai_case/domain/repositories/movie/i_movie_repository.dart';
import 'package:mobx/mobx.dart';

part 'movie_store.g.dart';

class MovieStore = _MovieStore with _$MovieStore;

abstract class _MovieStore with Store {
  _MovieStore(this._repository, this._cacheService);
  final IMovieRepository _repository;
  final ICacheService _cacheService;

  @observable
  bool isMoviesLoading = false;

  @observable
  bool isGenresLoading = false;

  @observable
  bool isRecommendationsLoading = false;

  @observable
  bool isSearchLoading = false;

  @observable
  Failure? moviesFailure;

  @observable
  Failure? genresFailure;

  @observable
  Failure? recommendationsFailure;

  @observable
  Failure? searchFailure;

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
  bool get hasError => moviesFailure != null;

  @action
  Future<void> getMovies({int page = 1, bool loadMore = false}) async {
    if (isMoviesLoading) return;

    isMoviesLoading = true;
    moviesFailure = null;

    final result = await _repository.getMovies(page: page);

    result.fold((error) => moviesFailure = error, (data) {
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

    isMoviesLoading = false;
  }

  @action
  Future<void> getGenres() async {
    if (isGenresLoading) return;

    isGenresLoading = true;
    genresFailure = null;
    final result = await _repository.getGenres();
    result.fold((error) => genresFailure = error, (data) => genres = data);

    isGenresLoading = false;
  }

  @action
  Future<void> getRecommendations() async {
    if (isRecommendationsLoading) return;

    isRecommendationsLoading = true;
    recommendationsFailure = null;

    final favoriteMovieIds = _cacheService.readStringList(
      CacheKey.favoriteMovieIds,
    );
    if (favoriteMovieIds == null || favoriteMovieIds.isEmpty) return;

    final size = favoriteMovieIds.length;
    final randomIndex = Random().nextInt(size);
    final id = int.parse(favoriteMovieIds[randomIndex]);
    final result = await _repository.getRecommendations(movieId: id);

    result.fold(
      (error) => recommendationsFailure = error,
      (data) => recommendations = data,
    );

    isRecommendationsLoading = false;
  }

  @action
  Future<void> searchMovies(String query) async {
    if (isSearchLoading) return;

    isSearchLoading = true;
    searchFailure = null;

    if (query.isEmpty) {
      searchResults = MovieInformationData.empty();
      searchQuery = '';
      return;
    }

    isSearchLoading = true;
    searchFailure = null;
    searchQuery = query;

    final result = await _repository.searchMovies(query: query);

    result.fold(
      (error) => moviesFailure = error,
      (data) => searchResults = data,
    );

    isSearchLoading = false;
  }

  @action
  void clearSearch() {
    searchResults = MovieInformationData.empty();
    searchQuery = '';
  }

  @action
  void clearFailure() {
    moviesFailure = null;
  }

  @action
  Future<void> loadMoreMovies() async {
    if (!hasMorePages || isMoviesLoading) return;
    final nextPage = movieInformation.page + 1;
    await getMovies(page: nextPage, loadMore: true);
  }
}
