import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/core/usecase/usecase_interface.dart';
import 'package:project_neo/domain/entities/auth/user.dart';
import 'package:project_neo/domain/repositories/auth_repo.dart';

class UserSignUp implements UsecaseInterface<User, SignUpParams> {
  final AuthRepo authRepo;

  UserSignUp({required this.authRepo});
  @override
  Future<Either<Failure, User>> call(params) async {
    final respose = await authRepo.signUp(
      name: params.name,
      email: params.email,
      password: params.password,
    );
    return respose;
  }
}
 
final class SignUpParams {
  final String name;
  final String email;
  final String password;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
