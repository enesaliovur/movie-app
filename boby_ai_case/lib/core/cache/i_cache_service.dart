import 'cache_key.dart';

abstract class ICacheService {
  bool? readBool(CacheKey key);
  Future<void> writeBool(CacheKey key, bool value);
}
