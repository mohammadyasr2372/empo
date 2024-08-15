import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:party/core/strings/constans.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/error/exceptions.dart';
import '../../../../../injection_container.dart' as di;
import '../../../presentation/widgets/models/model_restaurant.dart';
import '../../models/restaurant_model/getdetails_restorant/getinforestorant.dart';
import '../../models/restaurant_model/getfood.dart';

abstract class ResturantDatasource {
  Future<Unit> addFoodDetailsdatasource({required MenuImage menuImage});
  Future<Unit> addResturantdetailsdatasource(
      {required AddRestaurant addRestaurant});
  Future<Getinforestorant> getresturantdetails_datasourece();
  Future<Getfood> getfood_datasourece(String ID);
}

String token = di.sl.get<SharedPreferences>().getString(CACHED_Token)!;

class ResturantDatasourceImpl implements ResturantDatasource {
  final Dio dio;
  ResturantDatasourceImpl({
    required this.dio,
  });
  @override
  Future<Unit> addResturantdetailsdatasource(
      {required AddRestaurant addRestaurant}) async {
    final request = http.MultipartRequest(
        'POST', _getUri('$BASE_URL/api/shopper/add_restorantInfo'));
    request.headers['token'] =
        di.sl.get<SharedPreferences>().getString(CACHED_Token)!;

    for (final imagePath in addRestaurant.rest_image) {
      final file = File(imagePath.path);
      request.files.add(await http.MultipartFile.fromPath(
        'rest_image',
        imagePath.path,
        filename: file.path.split('/').last,
        contentType: MediaType('image', 'png'),
      ));
    }

    request.fields.addAll({
      'all_table': addRestaurant.all_table.toString(),
      'number_booked': addRestaurant.number_booked.toString(),
      'price_table': addRestaurant.price_table.toString(),
      'data_rest': addRestaurant.date
    });

    final response = await request.send();
    if (response.statusCode == 200) {
      print('File upload successful ');
      final responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);
      di.sl.get<SharedPreferences>().setString(CACHED_ID_RESTORANT, data['ID']);
      print(data);
    } else {
      print('File upload failed with status code: ${response.statusCode}');
      print(
          'File upload failed with status code: ${await response.stream.bytesToString()}');
    }
    return Future.value(unit);
  }

  @override
  Future<Getinforestorant> getresturantdetails_datasourece() async {
    try {
      final response = await dio.get(
        '${BASE_URL}/api/shopper/getMyrestorant',
        options: Options(
          headers: {'token': token},
        ),
      );
      if (response.statusCode == 200) {
        final msgGetWeddhal = Getinforestorant.fromJson(response.data);
        return msgGetWeddhal;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error! Response data: ${e.response!.data}');
        print('Dio error! Status code: ${e.response?.statusCode}');
      } else {
        print('Dio error! Message: ${e.message}');
      }
      throw ServerException();
    }
  }

  @override
  Future<Getfood> getfood_datasourece(String ID) async {
    try {
      final response = await dio.get(
        '${BASE_URL}/api/shopper/getMyfood/$ID',
        options: Options(
          headers: {'token': token},
        ),
      );
      if (response.statusCode == 200) {
        final msgGetWeddhal = Getfood.fromJson(response.data);
        return msgGetWeddhal;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error! Response data: ${e.response!.data}');
        print('Dio error! Status code: ${e.response?.statusCode}');
      } else {
        print('Dio error! Message: ${e.message}');
      }
      throw ServerException();
    }
  }

  Uri _getUri(String url) {
    return Uri.parse(url);
  }

  @override
  Future<Unit> addFoodDetailsdatasource({required MenuImage menuImage}) async {
    final request =
        http.MultipartRequest('POST', _getUri('$BASE_URL/api/shopper/addFood'));
    request.headers['token'] =
        di.sl.get<SharedPreferences>().getString(CACHED_Token)!;

    final file = File(menuImage.image.path);
    request.files.add(await http.MultipartFile.fromPath(
      'food_image',
      menuImage.image.path,
      filename: file.path.split('/').last,
      contentType: MediaType('image', 'png'),
    ));

    request.fields.addAll({
      'restorId':
          di.sl.get<SharedPreferences>().getString(CACHED_ID_RESTORANT)!,
      'food_price': menuImage.price.toString(),
      'food_name': menuImage.name.toString(),
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
}
