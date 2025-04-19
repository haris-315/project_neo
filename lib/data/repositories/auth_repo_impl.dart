import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/custom_exceptions/server_exception.dart';

import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/data/sources/remote/auth_data_source.dart';
import 'package:project_neo/domain/entities/auth/user.dart';
import 'package:project_neo/domain/repositories/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class AuthRepositoryImpl implements AuthRepo {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<void> signOut() async {}

  @override
  Future<Either<Failure, User>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _getUser(
      () async => await authDataSource.signUp(email, password, name),
    );
  }

  @override
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  }) async {
    return await _getUser(
      () async => await authDataSource.signIn(email, password),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();
      return right(user);
    } on supabase.AuthException catch (e) {
      return left(Failure(message: e.toString()));
    } on ServerException catch (e) {
      return left(Failure(message: e.exception));
    }
  }

  @override
  Future<Either<Failure, User?>> getUserInfo() async {
    try {
      final res = await authDataSource.getUserInfo();
      if (res != null) {
        return right(res);
      }
      return right(null);
    } on supabase.AuthException catch (e) {
      return left(Failure(message: e.toString()));
    } on ServerException catch (e) {
      return left(Failure(message: e.exception));
    }
  }
}
