import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/core/services/session_manager_inerface.dart';

class SessionManager implements SessionManagerInterface {
  @override
  Future<Failure?> clearSession(String key, VoidCallback clearEvent) async {
    if (kDebugMode) {
      print("Failed to clear the user session on an unimplimented platform.");
    }
    return Failure(
      message: "Failed to clear the user session on an unimplimented platform.",
    );
  }

  @override
  Future<Either<Failure, String?>> retrieveSession(String key) async => left(
    Failure(
      message: "Failed to get the user session on an unimplimented platform.",
    ),
  );

  @override
  Future<Failure?> storeSession(String key, String value) async {
    if (kDebugMode) {
      print("Failed to store the user session on an unimplimented platform.");
    }
    return Failure(
      message: "Failed to store the user session on an unimplimented platform.",
    );
  }
}
