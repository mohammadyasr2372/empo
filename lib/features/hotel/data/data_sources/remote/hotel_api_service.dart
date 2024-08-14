// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:party/features/hotel/data/model/hotel_model.dart';
import 'package:party/injection_container.dart' as di;

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/strings/constans.dart';
import '../../../domain/entities/hotel_entity.dart';

abstract class HotelApiService {
  Future<Unit> add_hotelInfo({required Hotel newHotel});
  Future<Unit> updata_hotelInfo({required Hotel newHotel});
  Future<Unit> updata_star_hotel({required Hotel newHotel});
  Future<Unit> addDate_stay({required Hotel newHotel});
  Future<Hotel> avareg_stars_hotel();
  Future<Unit> give_star_hotel({required Hotel newHotel});
  Future<List<Hotel>> getmyfavorite();
  Future<Unit> add_favorite({required int idUser});
  Future<Unit> deletefavorite({required Hotel newHotel});
}

class HotelApiServiceIpml implements HotelApiService {
  final Dio dio;
  late Response response;
  HotelApiServiceIpml({required this.dio});

  @override
  Future<Unit> addDate_stay({required Hotel newHotel}) async {
    try {
      final response =
          await dio.post("$BASE_URL/api/login", data: newHotel.toJson());

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
  Future<Unit> add_favorite({required int idUser}) async {
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

  Uri _getUri(String url) {
    return Uri.parse(url);
  }

  @override
  Future<Unit> add_hotelInfo({required Hotel newHotel}) async {
    final request = http.MultipartRequest(
        'POST', _getUri('$BASE_URL/api/shopper/add_hotelInfo'));
    request.headers['token'] =
        di.sl.get<SharedPreferences>().getString(CACHED_Token)!;

    for (final imagePath in newHotel.imagesHotel!) {
      final file = File(imagePath.path);
      request.files.add(await http.MultipartFile.fromPath(
        'imagesHotel',
        imagePath.path,
        filename: file.path.split('/').last,
        contentType: MediaType('image', 'png'),
      ));
    }

    final response = await request.send();
    if (response.statusCode == 200) {
      print('File upload successful ');

      final responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);
      print(data);
      print(data['ID']);

      di.sl.get<SharedPreferences>().setString(CACHED_ID_HOTEL, data['ID']);
    } else {
      print('File upload failed with status code: ${response.statusCode}');
    }
    return Future.value(unit);
  }

  @override
  Future<Hotel> avareg_stars_hotel() async {
    final response = await dio.get(
      "$BASE_URL/posts/",
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.data['']);
      final HotelModel hotelModel = HotelModel.fromJson(decodedJson);

      return hotelModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletefavorite({required Hotel newHotel}) async {
    try {
      final response =
          await dio.post("$BASE_URL/api/login", data: newHotel.toJson());

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
  Future<List<Hotel>> getmyfavorite() async {
    final response = await dio.get(
      "$BASE_URL/posts/",
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.data) as List;
      final List<HotelModel> hotelModels = decodedJson
          .map<HotelModel>(
              (jsonHotelModel) => HotelModel.fromJson(jsonHotelModel))
          .toList();

      return hotelModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> give_star_hotel({required Hotel newHotel}) async {
    try {
      final response =
          await dio.post("$BASE_URL/api/login", data: newHotel.toJson());

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
  Future<Unit> updata_hotelInfo({required Hotel newHotel}) async {
    try {
      final response =
          await dio.post("$BASE_URL/api/login", data: newHotel.toJson());

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
  Future<Unit> updata_star_hotel({required Hotel newHotel}) async {
    try {
      final response =
          await dio.post("$BASE_URL/api/login", data: newHotel.toJson());

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
