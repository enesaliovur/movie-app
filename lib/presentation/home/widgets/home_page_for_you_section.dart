part of '../home_page.dart';

class HomePageForYouSection extends StatelessWidget {
  const HomePageForYouSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: RichText(
            text: TextSpan(
              text: "For You",
              style: context.fs18W600,
              children: [TextSpan(text: " ⭐️", style: context.fs20W600)],
            ),
          ),
        ),
        SizedBox(height: 16.sp),
        Observer(
          builder: (context) {
            final recommendationStore = getIt<RecommendationStore>();
            final recommendedMovies = recommendationStore.recommendedMovies;

            if (recommendationStore.isLoading) {
              return SizedBox(
                height: 80.sp,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[600]!,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 80.w,
                        height: 80.h,
                        margin: EdgeInsets.only(
                          right: 16.w,
                          left: index == 0 ? 16.w : 0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: context.radius100,
                        ),
                      );
                    },
                  ),
                ),
              );
            }

            if (recommendationStore.hasError) {
              return SizedBox(
                height: 80.h,
                child: Center(
                  child: DefaultRetryButton(
                    onTap: () {
                      recommendationStore.fetchRecommendations();
                    },
                  ),
                ),
              );
            }

            if (recommendedMovies.isEmpty) {
              return SizedBox(
                height: 80.h,
                child: Center(
                  child: Text(
                    "No recommendations yet",
                    style: context.fs14W400,
                  ),
                ),
              );
            }

            return SizedBox(
              height: 80.sp,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommendedMovies.length,
                itemBuilder: (context, index) {
                  final movie = recommendedMovies[index];
                  return MovieCard(
                    movie.posterUrl,
                    borderRadius: context.radius100,
                    width: 80.w,
                    height: 80.h,
                    margin: EdgeInsets.only(
                      right: 16.w,
                      left: index == 0 ? 16.w : 0,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
