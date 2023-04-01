import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageRepository {
  final FlutterSecureStorage secureStorage;

  StorageRepository({FlutterSecureStorage? secureStorage})
      : secureStorage = const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
        );

  Future<String?> read(String key) async {
    try {
      final result = await secureStorage.read(key: key);
      return result;
    } catch (e) {
      delete(key);
      return Future.value(null);
    }
  }

  Future<bool> write(String key, String value) async {
    try {
      await secureStorage.write(key: key, value: value);
      return true;
    } catch (ex) {
      return false;
    }
  }

  Future<bool> delete(String key) async {
    try {
      await secureStorage.delete(key: key);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> replace(String key, String value) async {
    try {
      final deleteResult = await delete(key);
      if (deleteResult) {
        return await write(key, value);
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
