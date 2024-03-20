import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  CacheHelper._();
  static late SharedPreferences sharedPreferences;
  static late FlutterSecureStorage storage;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
  }

  static Future<String?> getSecureData({
    required String key,
  }) async {
    return await storage.read(key: key);
  }

  static Future<void> saveSecureData({
    required String key,
    required String value,
  }) async {
    return await storage.write(key: key, value: value);
  }

  static Future<void> removeSecureData({
    required String key,
  }) async {
    return await storage.delete(key: 'user');
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);

    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}
