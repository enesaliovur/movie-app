import 'package:boby_ai_case/data/models/movie/movie_data.dart';
import 'package:boby_ai_case/data/models/movie/movie_genre_data.dart';
import 'package:boby_ai_case/data/models/movie/movie_information_data.dart';
import 'package:boby_ai_case/domain/entities/movie/movie_entity.dart';
import 'package:boby_ai_case/domain/entities/movie/movie_genre_entity.dart';
import 'package:boby_ai_case/domain/entities/movie/paginated_movies_entity.dart';

class MovieMapper {
  static const String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  /// Converts [MovieData] DTO to [MovieEntity] domain model.
  static MovieEntity toEntity(MovieData dto) {
    return MovieEntity(
      id: dto.id,
      title: dto.title,
      overview: dto.overview,
      posterUrl: dto.posterPath.isNotEmpty
          ? '$_imageBaseUrl${dto.posterPath}'
          : '',
      backdropUrl: dto.backdropPath?.isNotEmpty == true
          ? '$_imageBaseUrl${dto.backdropPath}'
          : '',
      releaseDate: dto.releaseDate,
      voteAverage: dto.voteAverage,
      voteCount: dto.voteCount,
      genreIds: dto.genreIds,
      popularity: dto.popularity,
      isAdult: dto.adult,
    );
  }

  /// Converts [MovieGenreData] DTO to [MovieGenreEntity] domain model.
  static MovieGenreEntity toGenreEntity(MovieGenreData dto) {
    return MovieGenreEntity(id: dto.id, name: dto.name);
  }

  /// Converts [MovieInformationData] DTO to [PaginatedMoviesEntity] domain model.
  static PaginatedMoviesEntity toPaginatedEntity(MovieInformationData dto) {
    return PaginatedMoviesEntity(
      movies: dto.movies.map(toEntity).toList(),
      page: dto.page,
      totalPages: dto.totalPages,
    );
  }

  /// Converts a list of [MovieGenreData] DTOs to [MovieGenreEntity] list.
  static List<MovieGenreEntity> toGenreEntityList(List<MovieGenreData> dtos) {
    return dtos.map(toGenreEntity).toList();
  }
}
