import 'package:boby_ai_case/core/cache/cache_key.dart';
import 'package:boby_ai_case/core/cache/i_cache_service.dart';
import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:boby_ai_case/domain/entities/movie/movie_entity.dart';
import 'package:boby_ai_case/domain/entities/movie/movie_genre_entity.dart';
import 'package:boby_ai_case/domain/entities/movie/paginated_movies_entity.dart';
import 'package:boby_ai_case/domain/repositories/movie/i_movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:boby_ai_case/domain/repositories/account/i_account_repository.dart';

part 'onboarding_store.g.dart';

class OnboardingStore = _OnboardingStore with _$OnboardingStore;

abstract class _OnboardingStore with Store {
  _OnboardingStore(
    this._cacheService,
    this._accountRepository,
    this._movieRepository,
  );
  final ICacheService _cacheService;
  final IAccountRepository _accountRepository;
  final IMovieRepository _movieRepository;

  final PageController pageController = PageController();

  @observable
  ObservableList<int> selectedMovieIds = ObservableList<int>();

  @observable
  ObservableList<MovieGenreEntity> selectedGenres =
      ObservableList<MovieGenreEntity>();

  @observable
  bool isProcessing = false;

  @observable
  bool onboardingCompleted = false;

  @observable
  int currentPage = 0;

  // Movie fetching state
  @observable
  bool isMoviesLoading = false;

  @observable
  bool isGenresLoading = false;

  @observable
  Failure? moviesFailure;

  @observable
  Failure? genresFailure;

  @observable
  PaginatedMoviesEntity movieInformation = PaginatedMoviesEntity.empty();

  @observable
  List<MovieGenreEntity> genres = [];

  @computed
  List<MovieEntity> get movies => movieInformation.movies;

  @computed
  bool get hasMorePages => movieInformation.page < movieInformation.totalPages;

  @computed
  bool get hasError => moviesFailure != null || genresFailure != null;

  @computed
  bool get isValid {
    if (currentPage == 0) {
      return selectedMovieIds.length >= 3;
    } else {
      return selectedGenres.length >= 2;
    }
  }

  @action
  void addFavoriteMovie(int movieId) {
    if (selectedMovieIds.length == 3) return;
    selectedMovieIds.add(movieId);
  }

  @action
  void removeFavoriteMovie(int movieId) {
    selectedMovieIds.remove(movieId);
  }

  bool isFavoriteMovie(int movieId) {
    return selectedMovieIds.contains(movieId);
  }

  @action
  void addFavoriteGenre(MovieGenreEntity genre) {
    if (selectedGenres.length == 2) return;
    selectedGenres.add(genre);
  }

  @action
  void removeFavoriteGenre(MovieGenreEntity genre) {
    selectedGenres.remove(genre);
  }

  bool isFavoriteGenre(MovieGenreEntity genre) {
    return selectedGenres.contains(genre);
  }

  @action
  Future<void> nextPage() async {
    assert(isValid);

    if (currentPage == 0) {
      isProcessing = true;
      try {
        await Future.wait(
          selectedMovieIds.map(
            (id) => _accountRepository.addFavorite(movieId: id),
          ),
        );
      } finally {
        await _cacheService.writeStringList(
          CacheKey.favoriteMovieIds,
          selectedMovieIds.map((e) => e.toString()).toList(),
        );
        isProcessing = false;
      }

      currentPage = 1;
      pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (currentPage == 1) {
      isProcessing = true;
      await _cacheService.writeBool(CacheKey.onboardingCompleted, true);
      onboardingCompleted = true;

      isProcessing = false;
    }
  }

  @action
  Future<void> getMovies({int page = 1, bool loadMore = false}) async {
    if (isMoviesLoading) return;

    isMoviesLoading = true;
    moviesFailure = null;

    final result = await _movieRepository.getMovies(page: page);

    result.fold((error) => moviesFailure = error, (data) {
      if (loadMore) {
        movieInformation = PaginatedMoviesEntity(
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
    final result = await _movieRepository.getGenres();
    result.fold((error) => genresFailure = error, (data) => genres = data);

    isGenresLoading = false;
  }

  @action
  Future<void> loadMoreMovies() async {
    if (!hasMorePages || isMoviesLoading) return;
    final nextPage = movieInformation.page + 1;
    await getMovies(page: nextPage, loadMore: true);
  }

  void dispose() {
    pageController.dispose();
  }
}
