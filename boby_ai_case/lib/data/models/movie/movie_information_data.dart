import 'package:boby_ai_case/data/models/movie/movie_data.dart';
import 'package:equatable/equatable.dart';

class MovieInformationData extends Equatable {
  const MovieInformationData({
    required this.movies,
    required this.page,
    required this.totalPages,
  });

  factory MovieInformationData.empty() {
    return const MovieInformationData(movies: [], page: 0, totalPages: 0);
  }

  factory MovieInformationData.fromMap(Map<String, dynamic> map) {
    return MovieInformationData(
      movies: (map['results'] as List)
          .map((e) => MovieData.fromMap(e))
          .toList(),
      page: map['page'] as int? ?? 0,
      totalPages: map['total_pages'] as int? ?? 0,
    );
  }

  final List<MovieData> movies;
  final int page;
  final int totalPages;

  Map<String, dynamic> toMap() {
    return {
      'results': movies.map((e) => e.toJson()).toList(),
      'page': page,
      'total_pages': totalPages,
    };
  }

  @override
  List<Object?> get props => [movies, page, totalPages];
}
