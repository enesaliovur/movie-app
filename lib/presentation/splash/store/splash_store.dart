import 'package:boby_ai_case/core/cache/cache_key.dart';
import 'package:boby_ai_case/core/cache/i_cache_service.dart';
import 'package:mobx/mobx.dart';

part 'splash_store.g.dart';

class SplashStore = _SplashStore with _$SplashStore;

abstract class _SplashStore with Store {
  final ICacheService cacheService;
  @observable
  bool showOnboarding = false;

  @observable
  bool isLoading = true;

  _SplashStore(this.cacheService);

  @action
  Future<void> init() async {
    isLoading = true;

    final onboardingCompleted =
        cacheService.readBool(CacheKey.onboardingCompleted) ?? false;

    showOnboarding = !onboardingCompleted;

    isLoading = false;
  }
}
