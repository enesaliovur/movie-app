import 'package:boby_ai_case/core/cache/i_cache_service.dart';
import 'package:boby_ai_case/core/cache/shared_pref_cache_service.dart';
import 'package:boby_ai_case/core/network/client.dart';
import 'package:boby_ai_case/core/network/mixin/http_failure_handler.dart';
import 'package:boby_ai_case/data/datasources/movie/i_movie_data_source.dart';
import 'package:boby_ai_case/data/datasources/account/i_account_data_source.dart';
import 'package:boby_ai_case/data/datasources/account/account_data_source.dart';
import 'package:boby_ai_case/data/datasources/movie/movie_data_source.dart';
import 'package:boby_ai_case/data/repositories/account/account_repository_impl.dart';
import 'package:boby_ai_case/data/repositories/movie/movie_repository_impl.dart';
import 'package:boby_ai_case/domain/repositories/account/i_account_repository.dart';
import 'package:boby_ai_case/domain/repositories/movie/i_movie_repository.dart';
import 'package:boby_ai_case/presentation/common/movie/store/movie_store.dart';
import 'package:boby_ai_case/presentation/home/store/recommendation_store.dart';
import 'package:boby_ai_case/presentation/onboarding/store/onboarding_store.dart';
import 'package:boby_ai_case/presentation/paywall/store/paywall_store.dart';
import 'package:boby_ai_case/presentation/search/store/movie_search_store.dart';
import 'package:boby_ai_case/presentation/splash/store/splash_store.dart';
import 'package:boby_ai_case/core/remote_config/i_remote_config_service.dart';
import 'package:boby_ai_case/core/remote_config/remote_config_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupInjector() async {
  // Cache Service
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  getIt.registerSingleton<ICacheService>(
    SharedPrefCacheService(sharedPreferences),
  );

  // Http Failure Handler
  getIt.registerSingleton<HttpFailureHandler>(const HttpFailureHandler());

  // Client
  getIt.registerSingleton<Client>(Client());

  // Remote Config Service
  getIt.registerSingleton<IRemoteConfigService>(RemoteConfigService());

  // Movie Feature
  getIt.registerSingleton<IMovieDataSource>(
    MovieDataSource(getIt<Client>(), getIt<HttpFailureHandler>()),
  );
  getIt.registerSingleton<IMovieRepository>(
    MovieRepositoryImpl(getIt<IMovieDataSource>(), getIt<HttpFailureHandler>()),
  );
  getIt.registerSingleton<MovieStore>(
    MovieStore(getIt<IMovieRepository>(), getIt<ICacheService>()),
  );

  // Splash
  getIt.registerFactory<SplashStore>(() => SplashStore(getIt<ICacheService>()));

  // Account Feature
  getIt.registerSingleton<IAccountDataSource>(
    UserDataSource(getIt<Client>(), getIt<HttpFailureHandler>()),
  );
  getIt.registerSingleton<IAccountRepository>(
    AccountRepositoryImpl(getIt<IAccountDataSource>()),
  );

  // Onboarding
  getIt.registerSingleton<OnboardingStore>(
    OnboardingStore(
      getIt<ICacheService>(),
      getIt<IAccountRepository>(),
      getIt<IMovieRepository>(),
    ),
  );

  // Recommendation
  getIt.registerSingleton<RecommendationStore>(
    RecommendationStore(getIt<IMovieRepository>(), getIt<IAccountRepository>()),
  );

  // Paywall
  getIt.registerFactory<PaywallStore>(
    () => PaywallStore(getIt<IRemoteConfigService>()),
  );

  // Movie Search
  getIt.registerFactory<MovieSearchStore>(
    () => MovieSearchStore(getIt<IMovieRepository>()),
  );
}
