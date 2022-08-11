abstract class Storage {
  Future<T?> get<T>(String key);
  Future<Map<String, dynamic>> getAll(Set<String> keys);

  Future<void> set(String key, {required dynamic data});
  Future<void> setAll(Map<String, dynamic> values);
  
  Future<void> delete(String key);
  Future<void> deleteAll(Set<String> keys);
}
