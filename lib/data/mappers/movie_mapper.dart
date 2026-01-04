import 'package:boby_ai_case/data/models/movie/movie_genre_model.dart';
import 'package:boby_ai_case/data/models/movie/movie_information_model.dart';
import 'package:boby_ai_case/data/models/movie/movie_model.dart';
import 'package:boby_ai_case/domain/entities/movie/movie_entity.dart';
import 'package:boby_ai_case/domain/entities/movie/movie_genre_entity.dart';
import 'package:boby_ai_case/domain/entities/movie/paginated_movies_entity.dart';

class MovieMapper {
  static const String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  /// Converts [MovieData] DTO to [MovieEntity] domain model.
  static MovieEntity toEntity(MovieModel dto) {
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
      originalLanguage: dto.originalLanguage,
      originalTitle: dto.originalTitle,
      video: dto.video,
    );
  }

  /// Converts [MovieGenreData] DTO to [MovieGenreEntity] domain model.
  static MovieGenreEntity toGenreEntity(MovieGenreModel dto) {
    return MovieGenreEntity(id: dto.id, name: dto.name);
  }

  /// Converts [MovieInformationModel] DTO to [PaginatedMoviesEntity] domain model.
  static PaginatedMoviesEntity toPaginatedEntity(MovieInformationModel dto) {
    return PaginatedMoviesEntity(
      movies: dto.movies.map(toEntity).toList(),
      page: dto.page,
      totalPages: dto.totalPages,
    );
  }

  /// Converts a list of [MovieGenreData] DTOs to [MovieGenreEntity] list.
  static List<MovieGenreEntity> toGenreEntityList(List<MovieGenreModel> dtos) {
    return dtos.map(toGenreEntity).toList();
  }
}
