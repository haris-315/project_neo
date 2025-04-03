import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/custom_exceptions/server_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/features/data/sources/remote/auth_data_source.dart';
import 'package:project_neo/features/domain/repositories/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepo {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  User? getCurrentUser() {
    return null;
  }

  @override
  Future<void> signOut() async {}

  @override
  Future<Either<Failure, String>> signUp(
    {required String name,
    required String email,
    required String password,}
  ) async {
    try {
      final userId = await authDataSource.signUp(email, password, name);
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(message: e.exception));
    }
  }
}
