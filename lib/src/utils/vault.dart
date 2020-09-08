import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Vault {

  static const String ISDARK = "IS_DARK";

  static FlutterSecureStorage _getStorage() {
    return const FlutterSecureStorage();
  }

  static Future<void> setIsDark(bool brightness) async {
    final store = _getStorage();
    return store.write(key: ISDARK, value: brightness ? 'true' : 'false');
  }

  static Future<bool> getIsDark() async {
    final store = _getStorage();
    final v = await store.readAll();
    if (!v.containsKey(ISDARK)) {
      await setIsDark(false);
    }
    return await store.read(key: ISDARK) == "true";
  }
}
