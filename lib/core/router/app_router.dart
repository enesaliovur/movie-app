import 'package:auto_route/auto_route.dart';
import 'package:boby_ai_case/domain/entities/movie/movie_entity.dart';
import 'package:boby_ai_case/presentation/home/home_page.dart';
import 'package:boby_ai_case/presentation/onboarding/onboarding_page.dart';
import 'package:boby_ai_case/presentation/paywall/guarded_paywall_page.dart';
import 'package:boby_ai_case/presentation/search/movie_search_page.dart';
import 'package:boby_ai_case/presentation/splash/splash_page.dart';
import 'package:boby_ai_case/presentation/movie_detail/movie_detail_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: MovieSearchRoute.page),
    AutoRoute(page: GuardedPaywallRoute.page),
    AutoRoute(page: MovieDetailRoute.page),
  ];
}
