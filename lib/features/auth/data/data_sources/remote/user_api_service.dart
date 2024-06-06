// ignore_for_file: unused_element
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:party/features/auth/data/model/user_model.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/strings/constans.dart';
import '../../../domain/entities/user_entity.dart';

abstract class UserApiService {
  Future<Unit> login({required User newUser});
  Future<Unit> register({required User newUser});
  Future<Unit> deleteUser();
  Future<Unit> updataProUser({required User newUser});
  Future<User> getPro();
  Future<Unit> changeMyPassword({required User newUser});
}

class UserApiServiceIpml implements UserApiService {
  final Dio dio;
  late Response response;
  UserApiServiceIpml({required this.dio});

  @override
  Future<Unit> changeMyPassword({required User newUser}) async {
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer ';
    final response = await dio.put("$BASE_URL/posts/", data: newUser.toJson());

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteUser() async {
    final response = await dio.delete("$BASE_URL/posts/");

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<User> getPro() async {
    final response = await dio.get(
      "$BASE_URL/posts/",
    );

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.data['']);
      final UserModel userModel = UserModel.fromJson(decodedJson);

      return userModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> login({required User newUser}) async {
    final response = await dio.post("$BASE_URL/api/login", data: newUser.toJson());

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> register({required User newUser}) async {
    print( newUser.toJson());
    final response = await dio.post('$BASE_URL/api/register', data: newUser.toJson());
    print("aawcacac");

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updataProUser({required User newUser}) async {
    final response = await dio.put("$BASE_URL/posts/", data: newUser.toJson());

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
