import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/core/usecase/usecase_interface.dart';
import 'package:project_neo/features/domain/entities/user.dart';
import 'package:project_neo/features/domain/repositories/auth_repo.dart';

class UserSignIn implements UsecaseInterface<User, SignInParams> {
  final AuthRepo authRepo;

  UserSignIn({required this.authRepo});
  @override
  Future<Either<Failure, User>> call(SignInParams params) async {
    final response = await authRepo.signIn(
      email: params.email,
      password: params.password,
    );
    return response;
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}
