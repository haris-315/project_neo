import 'package:flutter/material.dart';
import 'package:project_neo/core/services/session_manager_inerface.dart';

class SessionManager implements SessionManagerInerface {
  @override
  Future<void> clearSession(String key , VoidCallback clearEvent) async {}
  @override
  Future<String?> retriveSession(String key) async => null;

  @override
  Future<void> storeSession(String key, String value) async {}
}
