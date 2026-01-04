part of '../movie_search_page.dart';

class MovieSearchList extends StatelessWidget {
  const MovieSearchList({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final store = context.read<MovieSearchStore>();
        final movies = store.searchResults.movies;
        final hasFailure = store.hasFailure;
        final isLoadMoreLoading = store.isLoadMoreLoading;
        final query = store.lastQuery;
        final isFetching = store.isFetching;

        if (isFetching) {
          return const Center(child: DefaultProgressIndicator());
        }

        if (hasFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultRetryButton(
                  onTap: () {
                    store.searchMovies(query);
                  },
                ),
              ],
            ),
          );
        }

        if (query.isNotEmpty && movies.isEmpty) {
          return Center(
            child: Text(
              context.tr.search.noResults,
              style: context.textStyles.fs16W600,
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                controller: scrollController,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.h,
                  crossAxisSpacing: 8.w,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return MovieCard(
                    onTap: () {
                      context.router.push(MovieDetailRoute(movie: movie));
                    },
                    imageUrl: movie.posterUrl,
                    borderRadius: context.radius.radius12,
                  );
                },
              ),
            ),
            if (isLoadMoreLoading)
              Padding(
                padding: EdgeInsets.all(8.sp),
                child: const DefaultProgressIndicator(),
              ),
          ],
        );
      },
    );
  }
}
