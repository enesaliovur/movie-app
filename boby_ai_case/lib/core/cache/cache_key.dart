enum CacheKey {
  onboardingCompleted('onboarding_completded'),
  favoriteMovieIds('favorite_movie_ids');

  const CacheKey(this.value);
  final String value;
}
