import 'package:boby_ai_case/core/cache/i_cache_service.dart';
import 'package:boby_ai_case/core/cache/shared_pref_cache_service.dart';
import 'package:boby_ai_case/core/network/client.dart';
import 'package:boby_ai_case/core/network/mixin/http_failure_handler.dart';
import 'package:boby_ai_case/data/datasources/movie/movie_data_source.dart';
import 'package:boby_ai_case/data/repositories/movie/movie_repository.dart';
import 'package:boby_ai_case/domain/repositories/movie/i_movie_repository.dart';
import 'package:boby_ai_case/presentation/common/movie/store/movie_store.dart';
import 'package:boby_ai_case/presentation/splash/store/splash_store.dart';
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

  // Movie Feature
  getIt.registerSingleton<IMovieDataSource>(
    MovieDataSource(getIt<Client>(), getIt<HttpFailureHandler>()),
  );
  getIt.registerSingleton<IMovieRepository>(
    MovieRepository(getIt<IMovieDataSource>(), getIt<HttpFailureHandler>()),
  );
  getIt.registerFactory<MovieStore>(
    () => MovieStore(getIt<IMovieRepository>()),
  );

  // Splash
  getIt.registerFactory<SplashStore>(() => SplashStore(getIt<ICacheService>()));
}
