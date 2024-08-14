// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/room_entity.dart';

abstract class RoomRepository {
  // API methods
  Future<Either<Failure, Unit>> addRoom({required Room newRoom});
  Future<Either<Failure, Unit>> deleteRoom({required int idUser});
  Future<Either<Failure, Unit>> updateRoom({required Room newRoom});
  Future<Either<Failure, List<Room>>> getRooms();
  Future<Either<Failure, List<Room>>> getRoomsWithuser();
  Future<Either<Failure, List<Room>>> getMyRoomsWithUser();
  Future<Either<Failure, List<Room>>> getRooms_notBooked();
  Future<Either<Failure, Unit>> ChangeStayRoom({required Room newRoom});
}
