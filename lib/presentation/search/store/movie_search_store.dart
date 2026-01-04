import 'dart:async';

import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:boby_ai_case/domain/repositories/movie/i_movie_repository.dart';
import 'package:boby_ai_case/domain/entities/movie/paginated_movies_entity.dart';
import 'package:mobx/mobx.dart';

part 'movie_search_store.g.dart';

class MovieSearchStore = _MovieSearchStore with _$MovieSearchStore;

abstract class _MovieSearchStore with Store {
  final IMovieRepository _movieRepository;
  _MovieSearchStore(this._movieRepository);

  @observable
  PaginatedMoviesEntity searchResults = PaginatedMoviesEntity.empty();

  @observable
  String lastQuery = '';

  @observable
  Failure? failure;

  @observable
  bool isFetching = false;

  @observable
  bool isLoadMoreLoading = false;

  @computed
  bool get hasNextPage => searchResults.page < searchResults.totalPages;

  @computed
  bool get hasFailure => failure != null;

  Timer? _debounceTimer;

  @action
  Future<void> searchMovies(String query, {bool isLoadMore = false}) async {
    failure = null;
    isFetching = true;

    lastQuery = query;
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      searchResults = PaginatedMoviesEntity.empty();
      isFetching = false;
      return;
    }

    if (isLoadMore) {
      if (!hasNextPage || isLoadMoreLoading) return;
      isLoadMoreLoading = true;
    }

    void performSearch() async {
      failure = null;
      isFetching = true;

      final pageToLoad = isLoadMore ? searchResults.page + 1 : 1;

      final result = await _movieRepository.searchMovies(
        query: query,
        page: pageToLoad,
      );

      result.fold(
        (failure) {
          if (!isLoadMore) searchResults = PaginatedMoviesEntity.empty();
          this.failure = failure;
          isFetching = false;
        },
        (data) {
          if (isLoadMore) {
            searchResults = PaginatedMoviesEntity(
              movies: [...searchResults.movies, ...data.movies],
              page: data.page,
              totalPages: data.totalPages,
            );
          } else {
            searchResults = data;
          }
          failure = null;
          isFetching = false;
        },
      );
      isLoadMoreLoading = false;
    }

    if (isLoadMore) {
      performSearch();
    } else {
      // Added a debounce to send fewer requests to the API and improve performance
      _debounceTimer = Timer(const Duration(seconds: 2), performSearch);
    }
  }

  @action
  Future<void> loadMoreMovies() async {
    if (isLoadMoreLoading || !hasNextPage) return;
    await searchMovies(lastQuery, isLoadMore: true);
  }

  void dispose() {
    _debounceTimer?.cancel();
  }
}
