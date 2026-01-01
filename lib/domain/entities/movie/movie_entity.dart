import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  const MovieEntity({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterUrl,
    required this.backdropUrl,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.genreIds,
    required this.popularity,
    required this.isAdult,
  });

  final int id;
  final String title;
  final String overview;
  final String posterUrl;
  final String backdropUrl;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final List<int> genreIds;
  final double popularity;
  final bool isAdult;

  @override
  List<Object?> get props => [
    id,
    title,
    overview,
    posterUrl,
    backdropUrl,
    releaseDate,
    voteAverage,
    voteCount,
    genreIds,
    popularity,
    isAdult,
  ];
}
