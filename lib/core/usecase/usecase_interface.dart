import 'package:fpdart/fpdart.dart';
import 'package:project_neo/core/errors/failure.dart';

abstract interface class UsecaseInterface<T,P> {
  Future<Either<Failure, T>> call(P params);
}
