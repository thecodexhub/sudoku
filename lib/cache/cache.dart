/// {@template cache_client}
/// An in-memory cache client.
/// {@endtemplate}
class CacheClient {
  /// {@macro cache_client}
  CacheClient() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  /// Writes the [key] and [value] pair into the cache.
  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

  /// Find the value for the specified key.
  ///
  /// If the value is not found, it returns `null`.
  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}
