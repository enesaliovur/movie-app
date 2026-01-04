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
    // V2 Structure Support
    final content = map['content'] as Map<String, dynamic>?;
    final images = map['images'] as Map<String, dynamic>?;
    final metrics = map['metrics'] as Map<String, dynamic>?;
    final dates = map['dates'] as Map<String, dynamic>?;
    final flags = map['flags'] as Map<String, dynamic>?;
    final meta = map['meta'] as Map<String, dynamic>?;

    return MovieModel(
      id: map['id'] ?? 0,
      title: content?['title'] ?? '',
      overview: content?['overview'] ?? '',
      originalTitle: content?['original_title'] ?? '',
      originalLanguage: content?['original_language'] ?? '',
      posterPath: images?['poster_url'] ?? '',
      backdropPath: images?['backdrop_url'] ?? '',
      voteAverage: (metrics?['score'] as num?)?.toDouble() ?? 0.0,
      voteCount: metrics?['reviews'] ?? 0,
      popularity: (metrics?['popularity'] as num?)?.toDouble() ?? 0.0,
      releaseDate: dates?['theatrical_release'] ?? '',
      adult: flags?['is_adult'] ?? false,
      video: flags?['has_video'] ?? false,
      genreIds: List<int>.from(meta?['genre_ids'] ?? []),
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
