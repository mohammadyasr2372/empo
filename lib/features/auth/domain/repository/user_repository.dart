import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  // API methods
  Future<Either<Failure, Unit>> login({required User newUser});
  Future<Either<Failure, Unit>> register({required User newUser});
  Future<Either<Failure, Unit>> deleteUser();
  Future<Either<Failure, Unit>> updataProUser(
      {required User newUser});
  Future<Either<Failure, User>> getPro();
  Future<Either<Failure, Unit>> changeMyPassword(
      {required User newUser});
}
