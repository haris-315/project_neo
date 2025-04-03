import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/core/usecase/usecase_interface.dart';
import 'package:project_neo/domain/repositories/auth_repo.dart';

class UserSignUp implements UsecaseInterface<String, SignUpParams> {
  final AuthRepo repo;

  UserSignUp({required this.repo});
  @override
  Future<Either<Failure, String>> call(params) async {
    final respose = await repo.signUp(
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
