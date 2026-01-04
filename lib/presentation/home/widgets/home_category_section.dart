part of '../home_page.dart';

class HomeCategorySection extends StatelessWidget {
  const HomeCategorySection({
    super.key,
    required this.categoryName,
    required this.movies,
    required this.titleKey,
  });

  final String categoryName;
  final List<MovieEntity> movies;
  final GlobalKey titleKey;

  @override
  Widget build(BuildContext context) {
    final displayMovies = movies.take(9).toList();

    if (displayMovies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          key: titleKey,
          padding: EdgeInsets.only(left: 16.w, bottom: 16.h),
          child: Text(categoryName, style: context.textStyles.fs20W400),
        ),

        SizedBox(
          height: 140.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: displayMovies.length,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemBuilder: (context, index) {
              final movie = displayMovies[index];
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: MovieCard(
                  imageUrl: movie.posterUrl,
                  width: 100.w,
                  height: 140.h,
                  borderRadius: context.radius.radius8,
                  onTap: () {
                    context.router.push(MovieDetailRoute(movie: movie));
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
