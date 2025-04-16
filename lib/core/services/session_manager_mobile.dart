import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/core/services/session_manager_inerface.dart';

class SessionManager implements SessionManagerInterface {
  static final _secureStorage = FlutterSecureStorage();

  @override
  Future<Failure?> clearSession(String key, VoidCallback? clearEvent) async {
    try {
      await _secureStorage.delete(key: key);
      if (clearEvent != null) {
        clearEvent.call();
      }
          return null;

    } catch (e) {
      if (kDebugMode) {
        print('Error clearing session: $e');
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
      final session = await _secureStorage.read(key: key);
      return right(session);
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving session: $e');
      }
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
      await _secureStorage.write(key: key, value: value);
    } catch (e) {
      if (kDebugMode) {
        print('Error storing session: $e');
      }
      Failure(
        message: "Failed to store the user session",
        details: e.toString(),
      );
    }
    return null;
  }
}
