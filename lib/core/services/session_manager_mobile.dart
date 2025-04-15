
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_neo/core/services/session_manager_inerface.dart';

class SessionManager implements SessionManagerInerface {
  final _secureStorage = FlutterSecureStorage();

  @override
  Future<void> clearSession(String key, VoidCallback clearEvent) async {
    await _secureStorage.delete(key: key);
    clearEvent.call();
  }

  @override
  Future<String?> retriveSession(String key) async {
    final session = await _secureStorage.read(key: key);
    return session;
  }

  @override
  Future<void> storeSession(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }
}
