import 'package:boby_ai_case/core/extensions/localization/build_context_tr_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:boby_ai_case/domain/entities/movie/movie_genre_entity.dart';
import 'package:boby_ai_case/presentation/onboarding/store/onboarding_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingGenreSelectionStep extends StatelessWidget {
  const OnboardingGenreSelectionStep({
    super.key,
    required this.onboardingStore,
  });

  final OnboardingStore onboardingStore;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100.h,
            padding: EdgeInsets.only(top: 28.h, left: 20.w, right: 20.w),

            alignment: Alignment.centerLeft,
            child: _Header(onboardingStore: onboardingStore),
          ),
          Expanded(
            flex: 5,
            child: _GenreGrid(onboardingStore: onboardingStore),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onboardingStore});
  final OnboardingStore onboardingStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
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
                  child: Row(
                    children: [
                      Text(
                        context.tr.onboarding.thankYou,
                        style: context.fs24W700,
                      ),
                      Text(" 👍", style: context.fs24W700),
                    ],
                  ),
                )
              : SizedBox(
                  key: const ValueKey('notValid'),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.tr.onboarding.welcome,
                        style: context.fs24W700,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        context.tr.onboarding.chooseGenresTitle,
                        style: context.fs20W500,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class _GenreGrid extends StatelessWidget {
  const _GenreGrid({required this.onboardingStore});

  final OnboardingStore onboardingStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final genres = onboardingStore.genres;
        return GridView.builder(
          padding: EdgeInsets.only(
            top: 24.h,
            left: 24.w,
            right: 24.w,
            bottom: 100.h,
          ),
          itemCount: genres.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 64.w,
            mainAxisSpacing: 16.h,
          ),
          itemBuilder: (context, index) {
            final genre = genres[index];
            return _GenreItem(genre: genre, onboardingStore: onboardingStore);
          },
        );
      },
    );
  }
}

class _GenreItem extends StatelessWidget {
  const _GenreItem({required this.genre, required this.onboardingStore});

  final MovieGenreEntity genre;
  final OnboardingStore onboardingStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final isSelected = onboardingStore.isFavoriteGenre(genre);
        return GestureDetector(
          onTap: () {
            if (isSelected) {
              onboardingStore.removeFavoriteGenre(genre);
            } else {
              onboardingStore.addFavoriteGenre(genre);
            }
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? context.redLight : context.transparent,
                    width: 2.w,
                  ),
                ),
                child: Center(
                  child: Text(
                    genre.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.fs20W600.copyWith(color: context.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              if (isSelected)
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.redLight,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.w),
                      child: Icon(
                        Icons.check,
                        color: context.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
