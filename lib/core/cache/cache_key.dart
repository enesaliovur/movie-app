enum CacheKey {
  onboardingCompleted('onboarding_completed'),
  favoriteMovieIds('favorite_movie_ids');

  const CacheKey(this.value);
  final String value;
}
