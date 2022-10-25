import 'package:cfit/external/models/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageImpl implements Storage {
  final Future<SharedPreferences> sharedPreferences;

  StorageImpl({
    required this.sharedPreferences,
  });

  @override
  Future<T?> get<T>(String key) async {
    final storageResponse = (await sharedPreferences).get(key) as T?;
    return storageResponse;
  }

  @override
  Future<Map<String, dynamic>> getAll(Set<String> keys) async {
    final responses = <String, dynamic>{};
    for (final key in keys) {
      responses.addAll({key: (await sharedPreferences).get(key)});
    }
    return responses;
  }

  @override
  Future<void> set(String key, {required dynamic data}) async {
    final storage = await sharedPreferences;
    
    if (data is bool) {
      await storage.setBool(key, data);
    } else if (data is String) {
      await storage.setString(key, data);
    } else if (data is List<String>) {
      await storage.setStringList(key, data);
    } else if (data is int) {
      await storage.setInt(key, data);
    } else if (data is double) {
      await storage.setDouble(key, data);
    }
  }

  @override
  Future<void> setAll(values) async {
    final storage = await sharedPreferences;
    final List<Future<void>> futures = [];
    for (final value in values.entries) {
      final key = value.key;
      final data = value.value;
      if (data is bool) {
        futures.add(storage.setBool(key, data));
      } else if (data is String) {
        futures.add(storage.setString(key, data));
      } else if (data is List<String>) {
        futures.add(storage.setStringList(key, data));
      } else if (data is int) {
        futures.add(storage.setInt(key, data));
      } else if (data is double) {
        futures.add(storage.setDouble(key, data));
      }
    }
    await Future.wait(futures);
  }

  @override
  Future<void> delete(String key) async {
    (await sharedPreferences).remove(key);
  }

  @override
  Future<void> deleteAll(Set<String> keys) async {
    final storage = await sharedPreferences;

    final List<Future<void>> futures = [];
    for (final value in keys) {
      final key = value;
      futures.add(storage.remove(key));
    }
    await Future.wait(futures);
  }
}
