import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:boby_ai_case/domain/entities/movie/movie_entity.dart';
import 'package:boby_ai_case/domain/entities/movie/movie_genre_entity.dart';
import 'package:boby_ai_case/domain/entities/movie/paginated_movies_entity.dart';
import 'package:boby_ai_case/domain/repositories/movie/i_movie_repository.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore(this._movieRepository);
  final IMovieRepository _movieRepository;

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

  @observable
  int? selectedGenreId;

  @computed
  List<MovieEntity> get movies => movieInformation.movies;

  @computed
  bool get hasMorePages => movieInformation.page < movieInformation.totalPages;

  @computed
  bool get hasError => moviesFailure != null;

  @computed
  Map<int, List<MovieEntity>> get groupedMovies {
    final Map<int, List<MovieEntity>> grouped = {};
    for (final genre in genres) {
      grouped[genre.id] = movies
          .where((movie) => movie.genreIds.contains(genre.id))
          .toList();
    }
    return grouped;
  }

  @computed
  List<MovieGenreEntity> get availableGenres {
    return genres
        .where((genre) => groupedMovies[genre.id]?.isNotEmpty ?? false)
        .toList();
  }

  @action
  Future<void> fetchMovies({int page = 1, bool loadMore = false}) async {
    isMoviesLoading = true;
    moviesFailure = null;

    final result = await _movieRepository.getMovies(page: page);

    result.fold(
      (error) {
        moviesFailure = error;
      },
      (data) {
        if (loadMore) {
          movieInformation = PaginatedMoviesEntity(
            movies: [...movieInformation.movies, ...data.movies],
            page: data.page,
            totalPages: data.totalPages,
          );
        } else {
          movieInformation = data;
        }
      },
    );

    isMoviesLoading = false;
  }

  @action
  Future<void> fetchGenres() async {
    isGenresLoading = true;
    genresFailure = null;
    final result = await _movieRepository.getGenres();
    result.fold((error) => genresFailure = error, (data) => genres = data);

    isGenresLoading = false;
  }

  @action
  void selectGenre(int? genreId) {
    selectedGenreId = genreId;
  }

  @action
  Future<void> loadMoreMovies() async {
    if (!hasMorePages || isMoviesLoading) return;
    final nextPage = movieInformation.page + 1;
    await fetchMovies(page: nextPage, loadMore: true);
  }
}
