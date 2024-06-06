// ignore_for_file: non_constant_identifier_names, unused_element

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/strings/constans.dart';
import '../../../domain/entities/admin_entity.dart';
import '../../../domain/entities/shopper_entity.dart';
import '../../../domain/entities/user_entity.dart';
import '../../model/admin_model.dart';
import '../../model/shopper_model.dart';
import '../../model/user_model.dart';

abstract class AdminApiService {
  Future<List<User>> getUserWithAdmin();
  Future<List<Shopper>> getShopperWithAdmin();
  Future<Unit> changeMyPasswordAdmin({required Admin newAdmin});
  Future<Unit> loginAdmin({required Admin newAdmin});
  Future<Unit> logoutAdmin();
  Future<Unit> deleteUserAdmin({required int idUser});
  Future<Admin> getProAdmin();
  Future<Unit> updateProAdmin({required Admin newAdmin});
  Future<List<User>> getAllUsers();
  Future<List<Shopper>> getAllShoppers();
  Future<String> getCounterUsers();
  Future<String> getCounterShopper();
  Future<List<Shopper>> searchShoppers({required String event_name});
  Future<List<User>> searchUser({required String event_name});
}

class _AdminApiService implements AdminApiService {
  _AdminApiService({required this.dio});
  final Dio dio;
  late Response response;

  @override
  Future<Unit> changeMyPasswordAdmin({required Admin newAdmin}) async {
    final response =
        await dio.put("$BASE_URL/posts/", data: {'EventName': newAdmin});

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteUserAdmin({required int idUser}) async {
    final response = await dio.delete("$BASE_URL/posts/");

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Shopper>> getAllShoppers() async {
    final response = await dio.delete("$BASE_URL/posts/");

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.data) as List;
      final List<ShopperModel> shopperModels = decodedJson
          .map<ShopperModel>(
              (jsonShopperModel) => ShopperModel.fromJson(jsonShopperModel))
          .toList();

      return shopperModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<User>> getAllUsers() async {
    final response = await dio.delete("$BASE_URL/posts/");

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.data) as List;
      final List<UserModel> userModels = decodedJson
          .map<UserModel>((jsonUserModel) => UserModel.fromJson(jsonUserModel))
          .toList();

      return userModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> getCounterShopper() async {
    final response = await dio.delete("$BASE_URL/posts/");

    if (response.statusCode == 200) {
      return response.data['CounterShopper'];
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> getCounterUsers() async {
    final response = await dio.delete("$BASE_URL/posts/");

    if (response.statusCode == 200) {
      return response.data['CounterUsers'];
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Admin> getProAdmin() async {
    final response = await dio.get(
      "$BASE_URL/posts/",
    );

    if (response.statusCode == 200) {
      final AdminModel adminModel = AdminModel.fromJson(response.data['']);

      return adminModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Shopper>> getShopperWithAdmin() async {
    final response = await dio.delete("$BASE_URL/posts/");

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.data) as List;
      final List<ShopperModel> shopperModels = decodedJson
          .map<ShopperModel>(
              (jsonShopperModel) => ShopperModel.fromJson(jsonShopperModel))
          .toList();

      return shopperModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<User>> getUserWithAdmin() async {
    final response = await dio.delete("$BASE_URL/posts/");

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.data) as List;
      final List<UserModel> userModels = decodedJson
          .map<UserModel>((jsonUserModel) => UserModel.fromJson(jsonUserModel))
          .toList();

      return userModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> loginAdmin({required Admin newAdmin}) async {
    final response = await dio.post("$BASE_URL/posts/", data: newAdmin.toJson());

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> logoutAdmin() async {
    final response = await dio.delete("$BASE_URL/posts/");

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Shopper>> searchShoppers({required String event_name}) async {
    final response = await dio.delete("$BASE_URL/posts/");

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.data) as List;
      final List<ShopperModel> shopperModels = decodedJson
          .map<ShopperModel>(
              (jsonShopperModel) => ShopperModel.fromJson(jsonShopperModel))
          .toList();

      return shopperModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<User>> searchUser({required String event_name}) async {
    final response = await dio.delete("$BASE_URL/posts/");

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.data) as List;
      final List<UserModel> userModels = decodedJson
          .map<UserModel>((jsonUserModel) => UserModel.fromJson(jsonUserModel))
          .toList();

      return userModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateProAdmin({required Admin newAdmin}) async {
    final response = await dio.delete("$BASE_URL/posts/");

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
