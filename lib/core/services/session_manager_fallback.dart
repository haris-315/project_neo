import 'package:flutter/material.dart';
import 'package:project_neo/core/services/session_manager_inerface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager implements SessionManagerInerface {
  @override
  Future<void> clearSession(String key, VoidCallback clearEvent) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
    clearEvent.call();
  }

  @override
  Future<String?> retriveSession(String key) {
    // TODO: implement retriveSession
    throw UnimplementedError();
  }

  @override
  Future<void> storeSession(String key, String value) {
    // TODO: implement storeSession
    throw UnimplementedError();
  }
}
