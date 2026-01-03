part of '../pages/home_page.dart';

class HomePageMoviesSection extends StatefulWidget {
  const HomePageMoviesSection({super.key});

  @override
  State<HomePageMoviesSection> createState() => _HomePageMoviesSectionState();
}

class _HomePageMoviesSectionState extends State<HomePageMoviesSection> {
  late final MovieStore _movieStore;

  late final ScrollController _moviesScrollController;

  late final ScrollController _chipScrollController;

  final Map<int, GlobalKey> _sectionKeys = {};

  final Map<int, GlobalKey> _chipKeys = {};

  final GlobalKey _listKey = GlobalKey();

  bool _isUserScrolling = true;

  late ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    _movieStore = getIt<MovieStore>();
    _moviesScrollController = ScrollController();
    _chipScrollController = ScrollController();

    _moviesScrollController.addListener(_onMoviesScroll);

    _disposer = reaction<List<dynamic>>((_) => _movieStore.availableGenres, (
      genres,
    ) {
      for (final genre in genres) {
        _chipKeys.putIfAbsent(genre.id, () => GlobalKey());
        _sectionKeys.putIfAbsent(genre.id, () => GlobalKey());
      }
    }, fireImmediately: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectFirstGenreIfNeeded();
    });
  }

  @override
  void dispose() {
    _disposer();
    _moviesScrollController.removeListener(_onMoviesScroll);
    _moviesScrollController.dispose();
    _chipScrollController.dispose();
    super.dispose();
  }

  void _selectFirstGenreIfNeeded() {
    final genres = _movieStore.availableGenres;
    if (genres.isNotEmpty && _movieStore.selectedGenreId == null) {
      _movieStore.selectGenre(genres.first.id);
    }
  }

  void _onMoviesScroll() {
    if (!_isUserScrolling) return;
    if (!_moviesScrollController.hasClients) return;

    final genres = _movieStore.availableGenres;
    if (genres.isEmpty) return;

    if (_moviesScrollController.position.pixels >=
        _moviesScrollController.position.maxScrollExtent - 20) {
      final lastGenreId = genres.last.id;
      if (lastGenreId != _movieStore.selectedGenreId) {
        _movieStore.selectGenre(lastGenreId);
        _scrollChipToCenter(lastGenreId);
      }
      return;
    }

    double referenceY = 0;
    if (_listKey.currentContext != null) {
      final listRenderBox =
          _listKey.currentContext!.findRenderObject() as RenderBox?;
      if (listRenderBox != null) {
        referenceY = listRenderBox.localToGlobal(Offset.zero).dy;
      }
    }

    final threshold = referenceY + 140;

    int? selectedGenreId;

    for (final genre in genres) {
      final key = _sectionKeys[genre.id];
      if (key?.currentContext == null) continue;

      final renderBox = key!.currentContext!.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.hasSize) continue;

      final position = renderBox.localToGlobal(Offset.zero);
      final titleTop = position.dy;

      if (titleTop <= threshold) {
        selectedGenreId = genre.id;
      } else {
        break;
      }
    }

    if (selectedGenreId != null &&
        selectedGenreId != _movieStore.selectedGenreId) {
      _movieStore.selectGenre(selectedGenreId);
      _scrollChipToCenter(selectedGenreId);
    }
  }

  void _onGenreTap(int genreId) {
    _isUserScrolling = false;

    _movieStore.selectGenre(genreId);
    _scrollChipToCenter(genreId);

    final key = _sectionKeys[genreId];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        alignment: 0.0,
      ).then((_) {
        _isUserScrolling = true;
      });
    } else {
      _isUserScrolling = true;
    }
  }

  void _scrollChipToCenter(int genreId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (!_chipScrollController.hasClients) return;

      final key = _chipKeys[genreId];
      if (key?.currentContext == null) return;

      final renderBox = key!.currentContext!.findRenderObject() as RenderBox?;
      if (renderBox == null || !renderBox.hasSize) return;

      final chipPosition = renderBox.localToGlobal(Offset.zero);
      final chipWidth = renderBox.size.width;
      final screenWidth = MediaQuery.of(context).size.width;
      final targetOffset =
          _chipScrollController.offset +
          chipPosition.dx +
          (chipWidth / 2) -
          (screenWidth / 2);

      final maxExtent = _chipScrollController.position.maxScrollExtent;
      final clampedOffset = targetOffset.clamp(0.0, maxExtent);

      _chipScrollController.animateTo(
        clampedOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.h,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: RichText(
            text: TextSpan(
              text: "Movies",
              style: context.fs24W700,
              children: [TextSpan(text: " 🎬", style: context.fs24W700)],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: const HomePageSearchBar(),
        ),
        _buildGenreChips(),
        Expanded(child: _buildMoviesList()),
      ],
    );
  }

  Widget _buildGenreChips() {
    return Observer(
      builder: (context) {
        final genres = _movieStore.availableGenres;
        final selectedId = _movieStore.selectedGenreId;

        return SizedBox(
          height: 36.h,
          child: ListView.builder(
            controller: _chipScrollController,
            scrollDirection: Axis.horizontal,
            itemCount: genres.length,
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            itemBuilder: (context, index) {
              final genre = genres[index];
              final isSelected = genre.id == selectedId;

              // Key should already be created by reaction
              final key = _chipKeys[genre.id];

              return GenreChip(
                key: key,
                name: genre.name,
                isSelected: isSelected,
                onTap: () => _onGenreTap(genre.id),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildMoviesList() {
    return Observer(
      builder: (context) {
        final genres = _movieStore.availableGenres;
        final groupedMovies = _movieStore.groupedMovies;
        if (genres.isEmpty) {
          if (_movieStore.isMoviesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Text("No movies found", style: context.fs24W700),
          );
        }

        return SingleChildScrollView(
          key: _listKey,
          controller: _moviesScrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final genre in genres) ...[
                Builder(
                  builder: (context) {
                    final key = _sectionKeys[genre.id];

                    return CategorySection(
                      categoryName: genre.name,
                      movies: groupedMovies[genre.id] ?? [],
                      titleKey: key ?? GlobalKey(),
                    );
                  },
                ),
                SizedBox(height: 24.sp),
              ],
            ],
          ),
        );
      },
    );
  }
}
