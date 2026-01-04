import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:boby_ai_case/domain/entities/movie/movie_entity.dart';
import 'package:boby_ai_case/domain/repositories/account/i_account_repository.dart';
import 'package:boby_ai_case/domain/repositories/movie/i_movie_repository.dart';
import 'package:mobx/mobx.dart';

part 'recommendation_store.g.dart';

class RecommendationStore = _RecommendationStore with _$RecommendationStore;

abstract class _RecommendationStore with Store {
  _RecommendationStore(this._movieRepository, this._accountRepository);

  final IMovieRepository _movieRepository;
  final IAccountRepository _accountRepository;

  @observable
  bool isLoading = false;

  @observable
  Failure? failure;

  @observable
  ObservableList<MovieEntity> similarMovies = ObservableList<MovieEntity>();

  @observable
  ObservableList<int> favoriteMovieIds = ObservableList<int>();

  @computed
  List<MovieEntity> get recommendedMovies => similarMovies.toList();

  @computed
  bool get hasError => failure != null;

  @computed
  bool get hasRecommendations => similarMovies.isNotEmpty;

  @action
  Future<void> _fetchSimilarMovies(int movieId) async {
    final result = await _movieRepository.getRecommendations(movieId: movieId);

    result.fold(
      (error) {
        return failure = error;
      },
      (data) {
        final prevList = similarMovies.toList();
        final newList = data.movies;
        final mergedList = [...prevList, ...newList];
        similarMovies = ObservableList.of(mergedList);
      },
    );
  }

  @action
  Future<void> fetchRecommendations() async {
    isLoading = true;
    failure = null;

    final result = await _accountRepository.getFavorites();

    await result.fold(
      (error) async {
        return failure = error;
      },
      (data) async {
        favoriteMovieIds = ObservableList.of(data.movies.map((e) => e.id));

        await Future.wait(
          favoriteMovieIds.map((id) => _fetchSimilarMovies(id)),
        );
      },
    );

    isLoading = false;
  }
}
