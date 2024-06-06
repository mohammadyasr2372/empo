import 'package:dartz/dartz.dart';
import 'package:party/features/auth/data/model/user_model.dart';
import 'package:party/features/auth/domain/entities/user_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/function/messages.dart';
import '../../domain/repository/user_repository.dart';
import '../data_sources/local/user_local_data.dart';
import '../data_sources/remote/user_api_service.dart';

class UsersRepositoryImpl implements UserRepository {
  final UserApiService userApiService;
  final UserLocalData userLocalData;

  final NetworkInfo networkInfo;

  UsersRepositoryImpl(
      {required this.userApiService,
      required this.userLocalData,
      required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> changeMyPassword(
      {required User newUser}) async {
    return await getMessage(networkInfo, () {
      return userApiService.changeMyPassword(newUser: newUser);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteUser() async {
    return await getMessage(networkInfo, () {
      return userApiService.deleteUser();
    });
  }

  @override
  Future<Either<Failure, User>> getPro() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser = await userApiService.getPro();
        userLocalData.cacheUsers(remoteUser as UserModel);
        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localUser = await userLocalData.getCachedProUser();
        return Right(localUser);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> login({required User newUser}) async {
    return await getMessage(networkInfo, () {
      return userApiService.login(newUser: newUser);
    });
  }

  @override
  Future<Either<Failure, Unit>> register({required User newUser}) async {
    return await getMessage(networkInfo, () {
      return userApiService.register(newUser: newUser);
    });
  }

  @override
  Future<Either<Failure, Unit>> updataProUser({required User newUser}) async {
    return await getMessage(networkInfo, () {
      return userApiService.updataProUser(newUser: newUser);
    });
  }
}
