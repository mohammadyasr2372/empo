// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/strings/constans.dart';
import '../../../domin/entites/room_entity.dart';
import '../../model/room_model.dart';

abstract class RoomApiService {
  Future<Unit> addRoom({required Room newRoom});
  Future<Unit> deleteRoom({required int idUser});
  Future<Unit> updateRoom({required Room newRoom});
  Future<List<Room>> getRooms();
  Future<List<Room>> getRoomsWithuser();
  Future<List<Room>> getMyRooms();
  Future<List<Room>> getMyRoomsWithUser();
  Future<List<Room>> getRooms_notBooked();
  Future<Unit> ChangeStayRoom({required Room newRoom});
}

class RoomApiServiceIpml implements RoomApiService {
  final Dio dio;
  late Response response;
  RoomApiServiceIpml({required this.dio});

  @override
  Future<Unit> ChangeStayRoom({required Room newRoom}) async {
    try {
      final response =
          await dio.post("$BASE_URL/api/login", data: newRoom.toJson());

      if (response.statusCode == 200) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addRoom({required Room newRoom}) async {
    try {
      final response =
          await dio.post("$BASE_URL/api/login", data: newRoom.toJson());

      if (response.statusCode == 200) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteRoom({required int idUser}) async {
    try {
      final response = await dio.post("$BASE_URL/api/login");

      if (response.statusCode == 200) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<Room>> getMyRooms() async {
    final response = await dio.get(
      "$BASE_URL/posts/",
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.data) as List;
      final List<RoomModel> roomModels = decodedJson
          .map<RoomModel>((jsonRoomModel) => RoomModel.fromJson(jsonRoomModel))
          .toList();

      return roomModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Room>> getMyRoomsWithUser() async {
    final response = await dio.get(
      "$BASE_URL/posts/",
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.data) as List;
      final List<RoomModel> roomModels = decodedJson
          .map<RoomModel>((jsonRoomModel) => RoomModel.fromJson(jsonRoomModel))
          .toList();

      return roomModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Room>> getRooms() async {
    final response = await dio.get(
      "$BASE_URL/posts/",
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.data) as List;
      final List<RoomModel> roomModels = decodedJson
          .map<RoomModel>((jsonRoomModel) => RoomModel.fromJson(jsonRoomModel))
          .toList();

      return roomModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Room>> getRoomsWithuser() async {
    final response = await dio.get(
      "$BASE_URL/posts/",
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.data) as List;
      final List<RoomModel> roomModels = decodedJson
          .map<RoomModel>((jsonRoomModel) => RoomModel.fromJson(jsonRoomModel))
          .toList();

      return roomModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Room>> getRooms_notBooked() async {
    final response = await dio.get(
      "$BASE_URL/posts/",
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.data) as List;
      final List<RoomModel> roomModels = decodedJson
          .map<RoomModel>((jsonRoomModel) => RoomModel.fromJson(jsonRoomModel))
          .toList();

      return roomModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateRoom({required Room newRoom}) async {
    try {
      final response =
          await dio.post("$BASE_URL/api/login", data: newRoom.toJson());

      if (response.statusCode == 200) {
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
