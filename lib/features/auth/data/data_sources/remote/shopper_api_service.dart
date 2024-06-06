// ignore_for_file: unused_element

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:party/features/auth/data/model/shopper_model.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/strings/constans.dart';
import '../../../domain/entities/shopper_entity.dart';
import '../../model/get_location_shopper.dart';

abstract class ShopperApiService {
  Future<Unit> loginShopper({required Shopper newShopper});
  Future<Unit> updateProShopper({required Shopper newShopper});
  Future<Shopper> getProShopper();
  Future<Unit> deleteShopper();
  Future<Unit> changeMyPasswordShopper({required Shopper newShopper});
  Future<Unit> changeMylocationShopper({required String location});
  Future<Unit> changeEventName({required String newEventName});
  Future<Shopper> informationDataWithEvent({required Shopper shopper});
  Future<Unit> registerShopper({required Shopper newShopper});
  Future<GetLocationShopper> getMylocation();
}

class ShopperApiServiceIpml implements ShopperApiService {
  ShopperApiServiceIpml({required this.dio});
  final Dio dio;
  late Response response;

  @override
  Future<Unit> changeEventName({required String newEventName}) async {
    final response =
        await dio.put("$BASE_URL/posts/", data: {'EventName': newEventName});

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> changeMyPasswordShopper({required Shopper newShopper}) async {
    final response =
        await dio.put("$BASE_URL/posts/", data: newShopper.toJson());

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> changeMylocationShopper({required String location}) async {
    final response =
        await dio.put("$BASE_URL/posts/", data: {'location': location});

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteShopper() async {
    final response = await dio.delete(
      "$BASE_URL/posts/",
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<GetLocationShopper> getMylocation() async {
    final response = await dio.get("$BASE_URL/posts/");

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.data['']);
      final GetLocationShopper getLocationShopper =
          GetLocationShopper.fromJson(decodedJson);

      return getLocationShopper;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Shopper> getProShopper() async {
    final response = await dio.get(
      "$BASE_URL/posts/",
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.data['']);
      final ShopperModel shopperModel = ShopperModel.fromJson(decodedJson);

      return shopperModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Shopper> informationDataWithEvent({required Shopper shopper}) async {
    final response = await dio.post("$BASE_URL/posts/", data: shopper.toJson());

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.data['']);
      final ShopperModel shopperModel = ShopperModel.fromJson(decodedJson);

      return shopperModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> loginShopper({required Shopper newShopper}) async {
    final response =
        await dio.post("$BASE_URL/posts/", data: newShopper.toJson());

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> registerShopper({required Shopper newShopper}) async {
    final response =
        await dio.post("$BASE_URL/posts/", data: newShopper.toJson());

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateProShopper({required Shopper newShopper}) async {
    final response =
        await dio.put("$BASE_URL/posts/", data: newShopper.toJson());

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
