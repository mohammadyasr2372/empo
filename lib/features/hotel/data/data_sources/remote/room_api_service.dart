// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
// import 'package:party/features/hotel/presentation/pages/hotel/post_hotel/hotel_post.dart';
import 'package:party/injection_container.dart' as di;
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/strings/constans.dart';
import '../../../domain/entities/room_entity.dart';
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
    final request = http.MultipartRequest(
        'POST', _getUri('http://localhost:3000/api/shopper/addRoom'));
    request.headers['token'] =
        di.sl.get<SharedPreferences>().getString(CACHED_Token)!;

    for (final imagePath in newRoom.image_room!) {
      final file = File(imagePath.path);
      request.files.add(await http.MultipartFile.fromPath(
        'image_room',
        imagePath.path,
        filename: file.path.split('/').last,
        contentType: MediaType('image', 'png'),
      ));
    }

    request.fields.addAll({
      'hotelId': di.sl.get<SharedPreferences>().getString(CACHED_ID_HOTEL)!,
      'name_room': newRoom.name_room!,
      'price_day': newRoom.price_day!,
      'room_type': newRoom.room_type!
    });

    final response = await request.send();
    if (response.statusCode == 200) {
      print('File upload successful ');

      final responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);
      print(data);
    } else {
      print('File upload failed with status code: ${response.statusCode}');
      print(
          'File upload failed with status code: ${await response.stream.bytesToString()}');
    }
    return Future.value(unit);
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

  Uri _getUri(String url) {
    return Uri.parse(url);
  }
}


//  {"success":false,"message":"Cannot read properties of undefined (reading 'map')"}
