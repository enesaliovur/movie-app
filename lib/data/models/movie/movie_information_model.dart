import 'package:boby_ai_case/data/models/movie/movie_model.dart';
import 'package:equatable/equatable.dart';

class MovieInformationModel extends Equatable {
  const MovieInformationModel({
    required this.movies,
    required this.page,
    required this.totalPages,
  });

  factory MovieInformationModel.empty() {
    return const MovieInformationModel(movies: [], page: 0, totalPages: 0);
  }

  factory MovieInformationModel.fromMap(Map<String, dynamic> map) {
    // V2 Structure Support
    final meta = map['meta'] as Map<String, dynamic>?;
    final data = map['data'] as Map<String, dynamic>?;

    return MovieInformationModel(
      movies: ((data?['movies'] ?? []) as List)
          .map((e) => MovieModel.fromMap(e))
          .toList(),
      page: meta?['current_page'] as int? ?? 0,
      totalPages: meta?['total_pages'] as int? ?? 0,
    );
  }

  final List<MovieModel> movies;
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
