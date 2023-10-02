import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'constant.dart';

class FlutterSecureStorageUtils {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static Future<bool?> getUserAuth() async {
    final result =
        await FlutterSecureStorageUtils()._storage.read(key: kUserAuth);

    if (result == null) {
      return null;
    }

    final decode = jsonDecode(result);

    final username = decode['username'];
    final password = decode['password'];

    if (username == null || password == null) {
      return null;
    }

    return true;
  }

  static Future<void> removeUserAuth() async {
    await FlutterSecureStorageUtils()._storage.delete(
          key: kUserAuth,
        );
  }

  static Future<void> setUserAuth({
    required String username,
    required String password,
  }) async {
    final value = jsonEncode({
      'username': username,
      'password': password,
    });

    await FlutterSecureStorageUtils()._storage.write(
          key: kUserAuth,
          value: value,
        );
  }
}
