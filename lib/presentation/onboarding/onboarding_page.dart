import 'package:boby_ai_case/core/di/setup_injector.dart';
import 'package:boby_ai_case/presentation/common/movie/store/movie_store.dart';
import 'package:boby_ai_case/presentation/home/pages/home_page.dart';
import 'package:boby_ai_case/presentation/home/store/recommendation_store.dart';
import 'package:boby_ai_case/presentation/onboarding/store/onboarding_store.dart';
import 'package:boby_ai_case/presentation/onboarding/widgets/onboarding_continue_button.dart';
import 'package:boby_ai_case/presentation/onboarding/widgets/onboarding_genre_selection_step.dart';
import 'package:boby_ai_case/presentation/onboarding/widgets/onboarding_movie_selection_step.dart';
import 'package:boby_ai_case/presentation/paywall/guarded_paywall_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final OnboardingStore _onboardingStore;
  late final MovieStore _movieStore;
  late final RecommendationStore _recommendationStore;
  late ReactionDisposer _onboardingCompletedReaction;

  @override
  void initState() {
    super.initState();
    _onboardingStore = getIt<OnboardingStore>();
    _movieStore = getIt<MovieStore>();
    _recommendationStore = getIt<RecommendationStore>();
    _onboardingCompletedReaction = reaction(
      (_) => _onboardingStore.onboardingCompleted,
      (bool completed) {
        if (completed && mounted) {
          _recommendationStore.fetchRecommendations();
          _movieStore.fetchMovies();
          _movieStore.fetchGenres();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const GuardedPaywallPage(fromOnboarding: true);
              },
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _onboardingStore.dispose();
    _onboardingCompletedReaction();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: PageView(
                controller: _onboardingStore.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  OnboardingMovieSelectionStep(
                    onboardingStore: _onboardingStore,
                  ),
                  OnboardingGenreSelectionStep(
                    onboardingStore: _onboardingStore,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 79.h,
              left: 0,
              right: 0,
              child: OnboardingContinueButton(
                onboardingStore: _onboardingStore,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
