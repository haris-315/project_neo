import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/core/services/session_manager_inerface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager implements SessionManagerInterface {
  SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> _getSharedPreferences() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  @override
  Future<Failure?> clearSession(String key, VoidCallback clearEvent) async {
    try {
      final sharedPreferences = await _getSharedPreferences();
      await sharedPreferences.remove(key);
      clearEvent.call();
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to clear session: $e');
      }
      return Failure(
        message: "Failed to clear user session",
        details: e.toString(),
      );
    }
  }

  @override
  Future<Either<Failure, String?>> retrieveSession(String key) async {
    try {
      final sharedPreferences = await _getSharedPreferences();
      final value = sharedPreferences.getString(key);

      return right(value);
    } catch (e) {
      return left(
        Failure(
          message: "Failed to retrieve the user session",
          details: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Failure?> storeSession(String key, String value) async {
    try {
      final sharedPreferences = await _getSharedPreferences();
      await sharedPreferences.setString(key, value);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to store session: $e');
      }
      Failure(
        message: "Failed to store the user session",
        details: e.toString(),
      );
    }
    return null;
  }
}
