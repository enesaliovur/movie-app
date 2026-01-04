import 'package:boby_ai_case/domain/entities/movie/movie_entity.dart';
import 'package:equatable/equatable.dart';

class MovieModel extends Equatable {
  const MovieModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      adult: map['adult'] ?? false,
      backdropPath: map['backdrop_path'] ?? '',
      genreIds: List<int>.from(map['genre_ids'] ?? []),
      id: map['id'] ?? 0,
      originalLanguage: map['original_language'] ?? '',
      originalTitle: map['original_title'] ?? '',
      overview: map['overview'] ?? '',
      popularity: (map['popularity'] as num?)?.toDouble() ?? 0.0,
      posterPath: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? '',
      title: map['title'] ?? '',
      video: map['video'] ?? false,
      voteAverage: (map['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: map['vote_count'] ?? 0,
    );
  }

  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'genre_ids': genreIds,
      'id': id,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  String get posterUrl {
    if (posterPath.isEmpty) return '';
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  String get backdropUrl {
    if (backdropPath?.isEmpty ?? true) return '';
    return 'https://image.tmdb.org/t/p/w780$backdropPath';
  }

  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      overview: overview,
      posterUrl: posterUrl,
      backdropUrl: backdropUrl,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      voteCount: voteCount,
      genreIds: genreIds,
      popularity: popularity,
      isAdult: adult,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      video: video,
    );
  }

  @override
  List<Object?> get props => [
    id,
    adult,
    backdropPath,
    genreIds,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount,
  ];
}
