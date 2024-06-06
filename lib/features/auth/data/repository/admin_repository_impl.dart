// ignore_for_file: non_constant_identifier_names, await_only_futures

import 'package:dartz/dartz.dart';
import 'package:party/core/error/failures.dart';
import 'package:party/features/auth/domain/entities/admin_entity.dart';
import 'package:party/features/auth/domain/entities/shopper_entity.dart';
import 'package:party/features/auth/domain/entities/user_entity.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/function/messages.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repository/admin_repository.dart';
import '../data_sources/local/admin_local_data.dart';
import '../data_sources/remote/admin_api_service.dart';
import '../model/admin_model.dart';

typedef Future<List<User>> FunctionUseListUser();
typedef Future<List<Shopper>> FunctionUseListShopper();

class AdminsRepositoryImpl implements AdminRepository {
  final AdminApiService adminApiService;
  final AdminLocalData adminLocalData;

  final NetworkInfo networkInfo;
  AdminsRepositoryImpl(
      {required this.adminApiService,
      required this.adminLocalData,
      required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> changeMyPasswordAdmin(
      {required Admin newAdmin}) async {
    return await getMessage(networkInfo, () {
      return adminApiService.changeMyPasswordAdmin(newAdmin: newAdmin);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteUserAdmin({required int idUser}) async {
    return await getMessage(networkInfo, () {
      return adminApiService.deleteUserAdmin(idUser: idUser);
    });
  }

  @override
  Future<Either<Failure, List<Shopper>>> getAllShoppers() async {
    return await _getShoppers(() {
      return adminApiService.getAllShoppers();
    });
  }

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    return await _getUsers(() {
      return adminApiService.getAllUsers();
    });
  }

  @override
  Future<Either<Failure, String>> getCounterShopper() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAdmin = await adminApiService.getCounterShopper();
        return Right(remoteAdmin);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getCounterUsers() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAdmin = await adminApiService.getCounterUsers();
        return Right(remoteAdmin);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Admin>> getProAdmin() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAdmin = await adminApiService.getProAdmin();
        adminLocalData.cacheAdmins(remoteAdmin as AdminModel);
        return Right(remoteAdmin);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localAdmin = await adminLocalData.getCachedProAdmin();
        return Right(localAdmin);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Shopper>>> getShopperWithAdmin() async {
    return await _getShoppers(() {
      return adminApiService.getShopperWithAdmin();
    });
  }

  @override
  Future<Either<Failure, List<User>>> getUserWithAdmin() async {
    return await _getUsers(() {
      return adminApiService.getUserWithAdmin();
    });
  }

  @override
  Future<Either<Failure, Unit>> loginAdmin({required Admin newAdmin}) async {
    return await getMessage(networkInfo, () {
      return adminApiService.loginAdmin(newAdmin: newAdmin);
    });
  }

  @override
  Future<Either<Failure, Unit>> logoutAdmin() async {
    return await getMessage(networkInfo, () {
      return adminApiService.logoutAdmin();
    });
  }

  @override
  Future<Either<Failure, List<Shopper>>> searchShoppers(
      {required String event_name}) async {
    return await _getShoppers(() {
      return adminApiService.searchShoppers(event_name: event_name);
    });
  }

  @override
  Future<Either<Failure, List<User>>> searchUser(
      {required String event_name}) async {
    return await _getUsers(() {
      return adminApiService.searchUser(event_name: event_name);
    });
  }

  @override
  Future<Either<Failure, Unit>> updateProAdmin(
      {required Admin newAdmin}) async {
    return await getMessage(networkInfo, () {
      return adminApiService.updateProAdmin(newAdmin: newAdmin);
    });
  }

  Future<Either<Failure, List<User>>> _getUsers(
      FunctionUseListUser functionUseListUser) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAdmin = await functionUseListUser;
        return Right(remoteAdmin as List<User>);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  Future<Either<Failure, List<Shopper>>> _getShoppers(
      FunctionUseListShopper functionUseListShopper) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAdmin = await functionUseListShopper;
        return Right(remoteAdmin as List<Shopper>);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
