// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:party/features/hotel/data/model/hotel_model.dart';

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

  @override
  Future<Unit> add_hotelInfo({required Hotel newHotel}) async {
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
