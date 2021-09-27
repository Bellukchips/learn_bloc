library cache;

/// library cache client

class CacheClient {
  /// {@macro cache_client}
  CacheClient() : _cache = <String, Object>{};

  final Map<String?, Object?>? _cache;

  /// Writes the provide [key], [value] pair to the in-memory cache.
  void write<T extends Object>({required String? key, required T? value}) {
    _cache?[key] = value;
  }

  /// looks up the value for provided [key]
  /// defaults to null if no value exists for the provided key
  T? read<T extends Object>({required String? key}) {
    final value = _cache?[key];
    if (value is T) return value;
    return null;
  }
}