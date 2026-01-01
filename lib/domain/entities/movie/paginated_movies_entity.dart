import 'package:boby_ai_case/domain/entities/movie/movie_entity.dart';
import 'package:equatable/equatable.dart';

class PaginatedMoviesEntity extends Equatable {
  const PaginatedMoviesEntity({
    required this.movies,
    required this.page,
    required this.totalPages,
  });

  factory PaginatedMoviesEntity.empty() {
    return const PaginatedMoviesEntity(movies: [], page: 0, totalPages: 0);
  }

  final List<MovieEntity> movies;
  final int page;
  final int totalPages;

  @override
  List<Object?> get props => [movies, page, totalPages];
}
