import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/domain/entities/user.dart';

abstract interface class AuthRepo {
  Future<Either<Failure,User>> signUp({required String name, required String email, required String password});

  Future<Either<Failure,User>> signIn({required String email, required String password});
  Future<Either<Failure,User?>> getUserInfo();

  Future<void> signOut();
}
