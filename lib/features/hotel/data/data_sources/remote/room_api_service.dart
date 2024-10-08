// ignore_for_file: non_constant_identifier_names, avoid_print

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
import '../../model/image_room_model.dart';
import '../../model/room_get.dart';
import '../../model/room_model.dart';

abstract class RoomApiService {
  Future<Unit> addRoom({required Room newRoom});
  Future<Unit> deleteRoom({required int idUser});
  Future<Unit> updateRoom({required Room newRoom});
  Future<List<Room>> getRooms();
  Future<List<Room>> getRoomsWithuser();
  Future<RoomGet> getMyRoom({required String id});
  Future<List<Room>> getMyRoomsWithUser();
  Future<List<Room>> getRooms_notBooked();
  Future<Unit> ChangeStayRoom({required Room newRoom});
  Future<List<ImageRoomModel>> getall_roomsWithsuperDelocs_shopper();
  Future<List<ImageRoomModel>> getMyroomVip_shopper();
  Future<List<ImageRoomModel>> getall_roomsWithDelocs_shopper();
  Future<List<ImageRoomModel>> getMyroomVip_User({required String id});
  Future<List<ImageRoomModel>> getall_roomsWithDelocs_User(
      {required String id});
  Future<List<ImageRoomModel>> getall_roomsWithsuperDelocs_User(
      {required String id});
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
    final request =
        http.MultipartRequest('POST', _getUri('$BASE_URL/api/shopper/addRoom'));
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
  Future<RoomGet> getMyRoom({required String id}) async {
    final response = await dio.get(
      "$BASE_URL/api/shopper/getMyroom/$id",
      options: Options(
        headers: {
          'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!,
          "Content-Type": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      ),
    );
    print('objectm');
    print(response.data['DataRoom']);
    if (response.statusCode == 200) {
      final RoomGet room = RoomGet.fromMap(response.data['DataRoom']);
      print('objectm');

      return room;
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

  @override
  Future<List<ImageRoomModel>> getMyroomVip_shopper() async {
    print(di.sl.get<SharedPreferences>().getString(CACHED_Token)!);
    print(
        "$BASE_URL/api/getMyroomVip_shopper/${di.sl.get<SharedPreferences>().getString(CACHED_ID_HOTEL)!}");
    final response = await dio.get(
      "$BASE_URL/api/shopper/getMyroomVip_shopper/${di.sl.get<SharedPreferences>().getString(CACHED_ID_HOTEL)!}",
      options: Options(
        headers: {
          'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!,
          "Content-Type": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      ),
    );

    if (response.statusCode == 200) {
      final List temp = response.data['imageRoom'] as List;
      final List<ImageRoomModel> imageRoomModels = List.generate(temp.length,
          (index) => ImageRoomModel.fromMap(response.data['imageRoom'][index]));

      return imageRoomModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ImageRoomModel>> getall_roomsWithsuperDelocs_shopper() async {
    print(di.sl.get<SharedPreferences>().getString(CACHED_Token)!);
    print(
        "$BASE_URL/api/shopper/getall_roomsWithsuperDelocs_shopper/${di.sl.get<SharedPreferences>().getString(CACHED_ID_HOTEL)!}");
    final response = await dio.get(
      "$BASE_URL/api/shopper/getall_roomsWithsuperDelocs_shopper/${di.sl.get<SharedPreferences>().getString(CACHED_ID_HOTEL)!}",
      options: Options(
        headers: {
          'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!,
          "Content-Type": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      ),
    );

    if (response.statusCode == 200) {
      print(response.data);
      final List temp = response.data['imageRoom'] as List;
      final List<ImageRoomModel> imageRoomModels = List.generate(temp.length,
          (index) => ImageRoomModel.fromMap(response.data['imageRoom'][index]));

      return imageRoomModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ImageRoomModel>> getall_roomsWithDelocs_shopper() async {
    final response = await dio.get(
      "$BASE_URL/api/shopper/getall_roomsWithDelocs_shopper/${di.sl.get<SharedPreferences>().getString(CACHED_ID_HOTEL)!}",
      options: Options(
        headers: {
          'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!,
          "Content-Type": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      ),
    );

    if (response.statusCode == 200) {
      final List temp = response.data['imageRoom'] as List;
      final List<ImageRoomModel> imageRoomModels = List.generate(temp.length,
          (index) => ImageRoomModel.fromMap(response.data['imageRoom'][index]));

      return imageRoomModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ImageRoomModel>> getMyroomVip_User({required String id}) async {
    print(di.sl.get<SharedPreferences>().getString(CACHED_Token)!);
    print(
        "$BASE_URL/api/getMyroomVipUser/${di.sl.get<SharedPreferences>().getString(CACHED_ID_HOTEL)!}");
    final response = await dio.get(
      "$BASE_URL/api/User/getMyroomVip_User/${di.sl.get<SharedPreferences>().getString(CACHED_ID_HOTEL)!}",
      options: Options(
        headers: {
          'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!,
          "Content-Type": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      ),
    );

    if (response.statusCode == 200) {
      final List temp = response.data['imageRoom'] as List;
      final List<ImageRoomModel> imageRoomModels = List.generate(temp.length,
          (index) => ImageRoomModel.fromMap(response.data['imageRoom'][index]));

      return imageRoomModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ImageRoomModel>> getall_roomsWithsuperDelocs_User(
      {required String id}) async {
    print(di.sl.get<SharedPreferences>().getString(CACHED_Token)!);
    print("$BASE_URL/api/getall_roomsWithsuperDelocs/$id");
    final response = await dio.get(
      "$BASE_URL/api/User/getall_roomsWithsuperDelocs_User/${di.sl.get<SharedPreferences>().getString(CACHED_ID_HOTEL)!}",
      options: Options(
        headers: {
          'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!,
          "Content-Type": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      ),
    );

    if (response.statusCode == 200) {
      print(response.data);
      final List temp = response.data['imageRoom'] as List;
      final List<ImageRoomModel> imageRoomModels = List.generate(temp.length,
          (index) => ImageRoomModel.fromMap(response.data['imageRoom'][index]));

      return imageRoomModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ImageRoomModel>> getall_roomsWithDelocs_User(
      {required String id}) async {
    final response = await dio.get(
      '$BASE_URL/api/getall_roomsWithDelocs/$id',
      options: Options(
        headers: {
          'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!,
          "Content-Type": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      ),
    );

    if (response.statusCode == 200) {
      final List temp = response.data['imageRoom'] as List;
      final List<ImageRoomModel> imageRoomModels = List.generate(temp.length,
          (index) => ImageRoomModel.fromMap(response.data['imageRoom'][index]));

      return imageRoomModels;
    } else {
      throw ServerException();
    }
  }

  Uri _getUri(String url) {
    return Uri.parse(url);
  }
}


//  {"success":false,"message":"Cannot read properties of undefined (reading 'map')"}
