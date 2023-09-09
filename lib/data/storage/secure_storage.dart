import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  writeSecureData(String key, String value) async =>
      await storage.write(key: key, value: value);

  readSecureData(String key) async => await storage.read(key: key);

  deleteSecureData(String key) async => await storage.delete(key: key);
}
