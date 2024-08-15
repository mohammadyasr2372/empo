import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:party/core/strings/constans.dart';
import 'package:party/injection_container.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../presentation/pages/cande/post_cande/post_cande.dart';
import '../../../presentation/widgets/models/model_cande.dart';
import '../../models/candeisshop_model/getSweet.dart';
import '../../models/candeisshop_model/getcandyShop_model.dart';

abstract class CandiesshopDatasource {
  Future<GetcandyshopModel> getCandiesShop_datasourece();
  Future<Getsweet> getSweet_datasourece(String ID);
  Future<Unit> addCandedetailsdatasource({required AddCande addCande});
  Future<Unit> addSweetDetailsdatasource({required MenuSweetImage menuImage});
}

String token = di.sl.get<SharedPreferences>().getString(CACHED_Token)!;

class CandiesshopDatasourceImpl implements CandiesshopDatasource {
  final Dio dio;
  CandiesshopDatasourceImpl({
    required this.dio,
  });
  @override
  Future<Unit> addCandedetailsdatasource({required AddCande addCande}) async {
    final request = http.MultipartRequest(
        'POST', _getUri('$BASE_URL/api/shopper/add_candshopInfo'));
    request.headers['token'] =
        di.sl.get<SharedPreferences>().getString(CACHED_Token)!;

    for (final imagePath in addCande.cande_image) {
      final file = File(imagePath.path);
      request.files.add(await http.MultipartFile.fromPath(
        'cande_image',
        imagePath.path,
        filename: file.path.split('/').last,
        contentType: MediaType('image', 'png'),
      ));
    }

    request.fields.addAll({
      'data_open': addCande.data_open,
    });

    final response = await request.send();
    if (response.statusCode == 200) {
      print('File upload successful ');
      final responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);
      di.sl.get<SharedPreferences>().setString(CACHED_ID_CANDE, data['ID']);
      print(data);
    } else {
      print('File upload failed with status code: ${response.statusCode}');
      print(
          'File upload failed with status code: ${await response.stream.bytesToString()}');
    }
    return Future.value(unit);
  }

  @override
  Future<GetcandyshopModel> getCandiesShop_datasourece() async {
    try {
      final response = await dio.get(
        '${BASE_URL}/api/shopper/getMyCandshop',
        options: Options(
          headers: {'token': token},
        ),
      );
      if (response.statusCode == 200) {
        final msgGetWeddhal = GetcandyshopModel.fromJson(response.data);
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
  Future<Getsweet> getSweet_datasourece(String ID) async {
    try {
      final response = await dio.get(
        '${BASE_URL}/api/getMysweet/$ID',
        options: Options(
          headers: {'token': token},
        ),
      );
      if (response.statusCode == 200) {
        final msgGetWeddhal = Getsweet.fromJson(response.data);
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
  Future<Unit> addSweetDetailsdatasource(
      {required MenuSweetImage menuImage}) async {
    final request = http.MultipartRequest(
        'POST', _getUri('$BASE_URL/api/shopper/addSweet'));
    request.headers['token'] =
        di.sl.get<SharedPreferences>().getString(CACHED_Token)!;

    final file = File(menuImage.sweet_image.path);
    request.files.add(await http.MultipartFile.fromPath(
      'sweet_image',
      menuImage.sweet_image.path,
      filename: file.path.split('/').last,
      contentType: MediaType('image', 'png'),
    ));

    request.fields.addAll({
      'candshopId': di.sl.get<SharedPreferences>().getString(CACHED_ID_CANDE)!,
      'sweet_price': menuImage.sweet_price.toString(),
      'sweet_name': menuImage.sweet_name.toString(),
      'sweet_amont': menuImage.sweet_amont.toString(),
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
