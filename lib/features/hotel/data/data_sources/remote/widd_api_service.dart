// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:party/core/error/exceptions.dart';
import 'package:party/injection_container.dart' as di;
import 'package:party/features/hotel/domain/entities/widd_hotel_post.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/strings/constans.dart';
import '../../model/get_widd_model.dart';

abstract class WiddApiService {
  Future<Unit> addWidd({required WiddHotelPost newWidd});
  Future<GetWiddModel> get_my_widd();
}

class WiddApiServiceIpml implements WiddApiService {
  final Dio dio;
  late Response response;
  WiddApiServiceIpml({required this.dio});

  @override
  Future<Unit> addWidd({required WiddHotelPost newWidd}) async {
    final id = di.sl.get<SharedPreferences>().getString(CACHED_ID_HOTEL)!;
    print(id);
    final request = http.MultipartRequest(
        'POST', _getUri('$BASE_URL/api/shopper/create_widd/$id'));
    request.headers['token'] =
        di.sl.get<SharedPreferences>().getString(CACHED_Token)!;

    for (final imagePath in newWidd.imagewids_hotal) {
      final file = File(imagePath.path);
      request.files.add(await http.MultipartFile.fromPath(
        'imagewids_hotal',
        imagePath.path,
        filename: file.path.split('/').last,
        contentType: MediaType('image', 'png'),
      ));
    }

    request.fields.addAll({
      'NameWiddin': newWidd.hotelId,
      'bookprice': newWidd.bookprice,
      'capacity': newWidd.capacity,
      'personbook': newWidd.personbook,
      'capacityMin': newWidd.capacityMin
    });
    print(newWidd);
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
  Future<GetWiddModel> get_my_widd() async {
    final response = await dio.get(
      "$BASE_URL/api/shopper/get_my_widd",
      options: Options(
        headers: {
          'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!,
          "Content-Type": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      ),
    );

    if (response.statusCode == 200) {
      final GetWiddModel getWiddModel =
          GetWiddModel.fromMap(response.data['DataWidding']);

      return getWiddModel;
    } else {
      throw ServerException();
    }
  }

  Uri _getUri(String url) {
    return Uri.parse(url);
  }
}
