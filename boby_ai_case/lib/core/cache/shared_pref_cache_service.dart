import 'package:boby_ai_case/core/cache/cache_key.dart';
import 'package:boby_ai_case/core/cache/i_cache_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefCacheService implements ICacheService {
  const SharedPrefCacheService(this._sharedPref);
  final SharedPreferences _sharedPref;

  @override
  bool? readBool(CacheKey key) {
    return _sharedPref.getBool(key.value);
  }

  @override
  Future<void> writeBool(CacheKey key, bool value) {
    return _sharedPref.setBool(key.value, value);
  }
}
