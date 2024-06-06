// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:party/features/auth/domain/entities/shopper_entity.dart';
import 'package:party/features/auth/domain/entities/user_entity.dart';

import '../../../../core/error/failures.dart';
import '../entities/admin_entity.dart';

abstract class AdminRepository {
  // API methods
  Future<Either<Failure, List<User>>> getUserWithAdmin();
  Future<Either<Failure, List<Shopper>>> getShopperWithAdmin();
  Future<Either<Failure, Unit>> changeMyPasswordAdmin(
      {required Admin newAdmin});
  Future<Either<Failure, Unit>> loginAdmin({required Admin newAdmin});
  Future<Either<Failure, Unit>> logoutAdmin();
  Future<Either<Failure, Unit>> deleteUserAdmin({required int idUser});
  Future<Either<Failure, Admin>> getProAdmin();
  Future<Either<Failure, Unit>> updateProAdmin({required Admin newAdmin});
  Future<Either<Failure, List<User>>> getAllUsers();
  Future<Either<Failure, List<Shopper>>> getAllShoppers();
  Future<Either<Failure, String>> getCounterUsers();
  Future<Either<Failure, String>> getCounterShopper();
  Future<Either<Failure, List<Shopper>>> searchShoppers(
      {required String event_name});
  Future<Either<Failure, List<User>>> searchUser({required String event_name});
}
