// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';

import 'package:party/core/error/failures.dart';

import 'package:party/features/hotel/domain/entities/room_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/function/messages.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repository/room_repository.dart';
import '../data_sources/remote/room_api_service.dart';

class RoomsRepositoryImpl implements RoomRepository {
  final RoomApiService roomApiService;
  // final RoomLocalData roomLocalData;

  final NetworkInfo networkInfo;
  RoomsRepositoryImpl(
      {required this.roomApiService,
      // required this.roomLocalData,
      required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> ChangeStayRoom({required Room newRoom}) async {
    return await getMessage(networkInfo, () {
      return roomApiService.ChangeStayRoom(newRoom: newRoom);
    });
  }

  @override
  Future<Either<Failure, Unit>> addRoom({required Room newRoom}) async {
    return await getMessage(networkInfo, () {
      return roomApiService.addRoom(newRoom: newRoom);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteRoom({required int idUser}) async {
    return await getMessage(networkInfo, () {
      return roomApiService.deleteRoom(idUser: idUser);
    });
  }

  @override
  Future<Either<Failure, List<Room>>> getMyRooms() async {
    // if (await networkInfo.isConnected) {
    try {
      final remoteRoom = await roomApiService.getMyRooms();
      // userLocalData.cacheUsers(remoteRoom as UserModel);
      return Right(remoteRoom);
    } on ServerException {
      return Left(ServerFailure());
    }

    // else {
    //   try {
    //     final localUser = await userLocalData.getCachedProUser();
    //     return Right(localUser);
    //   } on EmptyCacheException {
    //     return Left(EmptyCacheFailure());
    //   }
    // }
  }

  @override
  Future<Either<Failure, List<Room>>> getMyRoomsWithUser() async {
    try {
      final remoteRoom = await roomApiService.getMyRoomsWithUser();
      // userLocalData.cacheUsers(remoteRoom as UserModel);
      return Right(remoteRoom);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Room>>> getRooms() async {
    try {
      final remoteRoom = await roomApiService.getMyRoomsWithUser();
      // userLocalData.cacheUsers(remoteRoom as UserModel);
      return Right(remoteRoom);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Room>>> getRoomsWithuser() async {
    try {
      final remoteRoom = await roomApiService.getMyRoomsWithUser();
      // userLocalData.cacheUsers(remoteRoom as UserModel);
      return Right(remoteRoom);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Room>>> getRooms_notBooked() async {
    try {
      final remoteRoom = await roomApiService.getMyRoomsWithUser();
      // userLocalData.cacheUsers(remoteRoom as UserModel);
      return Right(remoteRoom);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateRoom({required Room newRoom}) async {
    return await getMessage(networkInfo, () {
      return roomApiService.updateRoom(newRoom: newRoom);
    });
  }
}
