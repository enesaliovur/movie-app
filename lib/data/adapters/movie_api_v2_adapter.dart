// Adapter method to simulate API V2 structure from V1 data
Map<String, dynamic> transformToV2(Map<String, dynamic> v1Data) {
  if (v1Data['results'] == null) return v1Data;

  final results = v1Data['results'] as List;
  final v2Movies = results.map((movie) {
    if (movie is! Map<String, dynamic>) return movie;
    return {
      'id': movie['id'],
      'content': {
        'title': movie['title'],
        'overview': movie['overview'],
        'original_title': movie['original_title'],
        'original_language': movie['original_language'],
      },
      'images': {
        'poster_url': movie['poster_path'],
        'backdrop_url': movie['backdrop_path'],
      },
      'metrics': {
        'score': movie['vote_average'],
        'reviews': movie['vote_count'],
        'popularity': movie['popularity'],
      },
      'dates': {'theatrical_release': movie['release_date']},
      'flags': {'is_adult': movie['adult'], 'has_video': movie['video']},
      'meta': {'genre_ids': movie['genre_ids']},
    };
  }).toList();

  return {
    'meta': {
      'current_page': v1Data['page'],
      'total_pages': v1Data['total_pages'],
    },
    'data': {'movies': v2Movies},
  };
}
