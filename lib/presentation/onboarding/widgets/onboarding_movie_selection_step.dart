part of '../onboarding_page.dart';

class OnboardingMovieSelectionStep extends StatefulWidget {
  const OnboardingMovieSelectionStep({super.key});

  @override
  State<OnboardingMovieSelectionStep> createState() =>
      _OnboardingMovieSelectionStepState();
}

class _OnboardingMovieSelectionStepState
    extends State<OnboardingMovieSelectionStep> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final onboardingStore = context.read<OnboardingStore>();
    if (_isNearEnd &&
        !onboardingStore.isMoviesLoading &&
        onboardingStore.hasMorePages) {
      onboardingStore.loadMoreMovies();
    }
  }

  bool get _isNearEnd {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= maxScroll - 200;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100.h,
            padding: EdgeInsets.only(top: 28.h, left: 20.w, right: 20.w),
            child: const _MovieSelectionHeader(),
          ),
          Expanded(
            child: Center(
              child: _MovieList(scrollController: _scrollController),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieSelectionHeader extends StatelessWidget {
  const _MovieSelectionHeader();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final onboardingStore = context.read<OnboardingStore>();
        final isValid = onboardingStore.isValid;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: isValid
              ? SizedBox(
                  key: const ValueKey('valid'),
                  width: double.infinity,
                  child: Text(
                    context.tr.onboarding.continueToNextStep,
                    style: context.textStyles.fs24W700,
                  ),
                )
              : SizedBox(
                  width: double.infinity,
                  key: const ValueKey('notValid'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.tr.onboarding.welcome,
                        style: context.textStyles.fs24W700,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        context.tr.onboarding.chooseMoviesTitle,
                        style: context.textStyles.fs20W500,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class _MovieList extends StatelessWidget {
  const _MovieList({required this.scrollController});

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 252.h,
      width: context.screenWidth,
      child: Observer(
        builder: (context) {
          final onboardingStore = context.read<OnboardingStore>();
          final movies = onboardingStore.movies;
          final isLoading = onboardingStore.isMoviesLoading;
          return Stack(
            children: [
              ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: movies.length + (isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == movies.length) {
                    return const _MovieCardShimmer();
                  }

                  final movie = movies[index];
                  return _MovieCard(movie: movie);
                },
              ),
              Positioned(
                bottom: -20.h,
                left: 0,
                right: 0,
                child: ClipOval(
                  child: Container(height: 40.h, color: context.colors.black),
                ),
              ),
              Positioned(
                top: -20.h,
                left: 0,
                right: 0,
                child: ClipOval(
                  child: Container(height: 40.h, color: context.colors.black),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MovieCardShimmer extends StatelessWidget {
  const _MovieCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      width: context.screenWidth * 0.5,
      child: Shimmer.fromColors(
        baseColor: context.colors.grayLight.withValues(alpha: 0.3),
        highlightColor: context.colors.grayLight.withValues(alpha: 0.1),
        child: Container(
          decoration: BoxDecoration(
            color: context.colors.grayLight,
            borderRadius: context.radius.radius16,
          ),
        ),
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  const _MovieCard({required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final onboardingStore = context.read<OnboardingStore>();
        final id = movie.id;
        final isFavorite = onboardingStore.isFavoriteMovie(id);
        return GestureDetector(
          onTap: () {
            if (isFavorite) {
              onboardingStore.removeFavoriteMovie(id);
            } else {
              onboardingStore.addFavoriteMovie(id);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: ClipRRect(
              borderRadius: context.radius.radius8,
              child: SizedBox(
                width: 180.w,
                height: 252.h,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl: movie.posterUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return const Center(
                            child: DefaultProgressIndicator(),
                          );
                        },
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    if (isFavorite) ...[
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [
                                context.colors.transparent,
                                context.colors.redLight.withValues(alpha: 0.3),
                              ],
                              center: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 24.h,
                        right: 8.w,
                        child: Icon(
                          Icons.check_circle_rounded,
                          color: context.colors.redLight,
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
