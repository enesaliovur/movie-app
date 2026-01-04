import 'package:auto_route/auto_route.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:boby_ai_case/domain/entities/movie/movie_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.movie});
  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400.h,
            pinned: true,
            backgroundColor: context.colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: movie.posterUrl,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.2),
                          Colors.black.withValues(alpha: 0.8),
                          context.colors.black,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: context.textStyles.fs24W700.copyWith(
                      fontSize: 32.sp,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: context.colors.yellow,
                        size: 20.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: context.textStyles.fs16W600,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        movie.releaseDate,
                        style: context.textStyles.fs16W400.copyWith(
                          color: context.colors.grayLight,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    movie.overview,
                    style: context.textStyles.fs16W400.copyWith(
                      color: context.colors.grayLight,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
