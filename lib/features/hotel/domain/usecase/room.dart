import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

import '../entities/room_entity.dart';
import '../repository/room_repository.dart';

class AddRoomUseCase {
  final RoomRepository _roomRepository;

  AddRoomUseCase(this._roomRepository);

  Future<Either<Failure, Unit>> call(Room room) {
    return _roomRepository.addRoom(newRoom: room);
  }
}

class DeleteRoomUseCase {
  final RoomRepository _roomRepository;

  DeleteRoomUseCase(this._roomRepository);

  Future<Either<Failure, Unit>> call(int id) {
    return _roomRepository.deleteRoom(idUser: id);
  }
}

class UpdateRoomUseCase {
  final RoomRepository _roomRepository;

  UpdateRoomUseCase(this._roomRepository);

  Future<Either<Failure, Unit>> call(Room room) {
    return _roomRepository.updateRoom(newRoom: room);
  }
}

class GetRoomsUseCase {
  final RoomRepository _roomRepository;

  GetRoomsUseCase(this._roomRepository);

  Future<Either<Failure, List<Room>>> call() {
    return _roomRepository.getRooms();
  }
}

class GetRoomsWithUserUseCase {
  final RoomRepository _roomRepository;

  GetRoomsWithUserUseCase(this._roomRepository);

  Future<Either<Failure, List<Room>>> call() {
    return _roomRepository.getRoomsWithuser();
  }
}

// class GetMyRoomsUseCase {
//   final RoomRepository _roomRepository;

//   GetMyRoomsUseCase(this._roomRepository);

//   Future<Either<Failure, List<Room>>> call() {
//     return _roomRepository.getMyRooms();
//   }
// }

class GetMyRoomsWithUserUseCase {
  final RoomRepository _roomRepository;

  GetMyRoomsWithUserUseCase(this._roomRepository);

  Future<Either<Failure, List<Room>>> call() {
    return _roomRepository.getMyRoomsWithUser();
  }
}

class GetRoomsNotBookedUseCase {
  final RoomRepository _roomRepository;

  GetRoomsNotBookedUseCase(this._roomRepository);

  Future<Either<Failure, List<Room>>> call() {
    return _roomRepository.getRooms_notBooked();
  }
}

class ChangeStayRoomUseCase {
  final RoomRepository _roomRepository;

  ChangeStayRoomUseCase(this._roomRepository);

  Future<Either<Failure, Unit>> call(Room room) {
    return _roomRepository.ChangeStayRoom(newRoom: room);
  }
}
