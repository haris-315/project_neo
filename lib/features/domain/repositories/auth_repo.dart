import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/errors/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRepo {
  Future<Either<Failure,String>> signUp({required String name, required String email, required String password});

  User? getCurrentUser();

  Future<void> signOut();
}
