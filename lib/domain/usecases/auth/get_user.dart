import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/errors/failure.dart';
import 'package:project_neo/core/usecase/usecase_interface.dart';
import 'package:project_neo/domain/entities/user.dart';
import 'package:project_neo/domain/repositories/auth_repo.dart';

class GetUser implements UsecaseInterface<User?, Null> {
  final AuthRepo authRepo;

  GetUser({required this.authRepo});
  @override
  Future<Either<Failure, User?>> call(Null params) async {
    return await authRepo.getUserInfo();
  }
}
