part of '../onboarding_page.dart';

class OnboardingGenreSelectionStep extends StatelessWidget {
  const OnboardingGenreSelectionStep({super.key});

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
            child: const _GenreSelectionHeader(),
          ),
          const Expanded(flex: 5, child: _GenreSelectionGrid()),
        ],
      ),
    );
  }
}

class _GenreSelectionHeader extends StatelessWidget {
  const _GenreSelectionHeader();

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
                  child: Row(
                    children: [
                      Text(
                        context.tr.onboarding.thankYou,
                        style: context.textStyles.fs24W700,
                      ),
                      Text(" 👍", style: context.textStyles.fs24W700),
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
                        style: context.textStyles.fs24W700,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        context.tr.onboarding.chooseGenresTitle,
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

class _GenreSelectionGrid extends StatelessWidget {
  const _GenreSelectionGrid();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final onboardingStore = context.read<OnboardingStore>();
        final genres = onboardingStore.genres;
        return GridView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ).copyWith(top: 24.h, bottom: 100.h),
          itemCount: genres.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 55.w,
            mainAxisSpacing: 20.h,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final genre = genres[index];
            return _GenreSelectionItem(genre: genre);
          },
        );
      },
    );
  }
}

class _GenreSelectionItem extends StatelessWidget {
  const _GenreSelectionItem({required this.genre});
  final MovieGenreEntity genre;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final onboardingStore = context.read<OnboardingStore>();
        final isSelected = onboardingStore.isFavoriteGenre(genre);
        return DefaultAnimatedContainer(
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
                  color: context.colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? context.colors.redLight
                        : context.colors.transparent,
                    width: 2.w,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: AutoSizeText(
                      genre.name,
                      maxLines: 1,
                      minFontSize: 12,
                      overflow: TextOverflow.ellipsis,
                      style: context.textStyles.fs20W600.copyWith(
                        color: context.colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              if (isSelected)
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colors.redLight,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.w),
                      child: Icon(
                        Icons.check,
                        color: context.colors.white,
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
