import 'package:flutter/material.dart';

abstract interface class SessionManagerInerface {
  Future<void> storeSession(String key, String value);
  Future<String?> retriveSession(String key);
  Future<void> clearSession(String key, VoidCallback clearEvent);
}
