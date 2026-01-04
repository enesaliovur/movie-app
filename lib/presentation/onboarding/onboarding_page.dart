import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:boby_ai_case/core/di/setup_injector.dart';
import 'package:boby_ai_case/core/extensions/localization/build_context_tr_ext.dart';
import 'package:boby_ai_case/core/extensions/responsive/build_context_screen_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_color_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_radius_ext.dart';
import 'package:boby_ai_case/core/extensions/theme/build_context_text_style_ext.dart';
import 'package:boby_ai_case/core/extensions/visualization/build_context_toast_ext.dart';
import 'package:boby_ai_case/core/failure/failure.dart';
import 'package:boby_ai_case/core/router/app_router.dart';
import 'package:boby_ai_case/core/shared/widgets/default_animated_container.dart';
import 'package:boby_ai_case/core/shared/widgets/default_button.dart';
import 'package:boby_ai_case/core/shared/widgets/default_progress_indicator.dart';
import 'package:boby_ai_case/domain/entities/movie/movie_entity.dart';
import 'package:boby_ai_case/domain/entities/movie/movie_genre_entity.dart';
import 'package:boby_ai_case/presentation/home/store/home_store.dart';
import 'package:boby_ai_case/presentation/home/store/recommendation_store.dart';
import 'package:boby_ai_case/presentation/onboarding/store/onboarding_store.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

part 'widgets/onboarding_genre_selection_step.dart';
part 'widgets/onboarding_movie_selection_step.dart';
part 'widgets/onboarding_continue_button.dart';

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final OnboardingStore _onboardingStore;
  late final HomeStore _homeStore;
  late final RecommendationStore _recommendationStore;
  late final PageController _pageController;
  late List<ReactionDisposer> _disposers;

  @override
  void initState() {
    super.initState();
    _onboardingStore = getIt<OnboardingStore>();
    _homeStore = getIt<HomeStore>();
    _recommendationStore = getIt<RecommendationStore>();
    _pageController = PageController();

    _disposers = [
      reaction((_) => _onboardingStore.onboardingCompleted, (bool completed) {
        if (completed && mounted) {
          _recommendationStore.fetchRecommendations();
          _homeStore.fetchMovies();
          _homeStore.fetchGenres();
          context.router.replace(GuardedPaywallRoute(fromOnboarding: true));
        }
      }),
      reaction((_) => _onboardingStore.currentPage, (int page) {
        if (mounted) {
          _pageController.animateToPage(
            page,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }),
      reaction<Failure?>((_) => _onboardingStore.moviesFailure, (failure) {
        if (failure != null && mounted) {
          context.showFailureToast();
        }
      }),
      reaction<Failure?>((_) => _onboardingStore.genresFailure, (failure) {
        if (failure != null && mounted) {
          context.showFailureToast();
        }
      }),
      reaction<Failure?>((_) => _onboardingStore.failure, (failure) {
        if (failure != null && mounted) {
          context.showFailureToast();
        }
      }),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Provider.value(
          value: _onboardingStore,
          child: Stack(
            children: [
              Positioned.fill(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    OnboardingMovieSelectionStep(),
                    OnboardingGenreSelectionStep(),
                  ],
                ),
              ),
              Positioned(
                bottom: 79.h,
                left: 0,
                right: 0,
                child: const OnboardingContinueButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
