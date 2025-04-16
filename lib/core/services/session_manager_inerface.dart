import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/errors/failure.dart';

abstract interface class SessionManagerInterface {
  Future<Failure?> storeSession(String key, String value);
  Future<Either<Failure, String?>> retrieveSession(String key);
  Future<Failure?> clearSession(String key, VoidCallback clearEvent);
}
