// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/strings/constans.dart';
import '../../../../../injection_container.dart' as di;
import '../../models/wedding_hall_model/get/get_averagestar_model.dart';
import '../../models/wedding_hall_model/get/report_get.dart';
import '../../models/wedding_hall_model/post/post_stars_model.dart';
import '../../models/wedding_hall_model/post/rebort_Post.dart';

abstract class Weddinghalldatasource {
  Future<Unit> addweddingdetailsdatasource(
    int bookprice,
    int capacity,
    int personbook,
    int capacityMin,
    List<File> imagewids,
  );
  Future<Unit> updateweddingdetailsdatasource(
    // int bookprice,
    // int capacity,
    // int personbook,
    // int capacityMin,
    // List<File> imagewids,
    DatawiddPOst datawiddpost,
  );
  Future<msg_Get_Wedd_hal> getweddingdetailsdatasourece();
  Future<Unit> addimagehospitdatasource(
    List<File> imagehospit,
  );
  Future<ReportStarModel> poststars_datasource(PostStarModle poststarModle);
  Future<averageStarsModel> AverageStarswedding_datasourece(
      IdStarModel Idstarmodel);
}

class WeddinghalldatasourceImpl implements Weddinghalldatasource {
  final Dio dio;
  WeddinghalldatasourceImpl({required this.dio});
  @override
  Future<Unit> addweddingdetailsdatasource(
    int bookprice,
    int capacity,
    int personbook,
    int capacityMin,
    List<File> imagewids,
  ) async {
    final request = http.MultipartRequest(
        'POST', _getUri('$BASE_URL/api/shopper/create_widd'));
    request.headers['token'] =
        di.sl.get<SharedPreferences>().getString(CACHED_Token)!;

    for (final imagePath in imagewids) {
      final file = File(imagePath.path);
      request.files.add(await http.MultipartFile.fromPath(
        'imagewids',
        imagePath.path,
        filename: file.path.split('/').last,
        contentType: MediaType('image', 'png'),
      ));
    }

    request.fields.addAll({
      'bookprice': bookprice.toString(),
      'capacity': capacity.toString(),
      'personbook': personbook.toString(),
      'capacityMin': capacityMin.toString(),
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
  Future<Unit> addimagehospitdatasource(List<File> imagehospit) async {
    final request = http.MultipartRequest(
        'PUT', _getUri('$BASE_URL/api/shopper/add_image_hospit'));
    request.headers['token'] =
        di.sl.get<SharedPreferences>().getString(CACHED_Token)!;

    for (final imagePath in imagehospit) {
      final file = File(imagePath.path);
      request.files.add(await http.MultipartFile.fromPath(
        'imagehospit',
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
    } else {
      print('File upload failed with status code: ${response.statusCode}');
      print(
          'File upload failed with status code: ${await response.stream.bytesToString()}');
    }
    return Future.value(unit);
  }

  @override
  Future<Unit> updateweddingdetailsdatasource(DatawiddPOst datawiddpost) async {
    FormData formData = FormData.fromMap({
      'bookprice': datawiddpost.bookprice,
      'capacity': datawiddpost.capacity,
      'personbook': datawiddpost.personbook,
      'capacityMin': datawiddpost.capacityMin,
      'images': datawiddpost.imagewids
          .map((file) => MultipartFile.fromFileSync(file.id!.path))
          .toList(),
    });

    try {
      final response = await dio.put(
        '${BASE_URL}/api/shopper/update_widd',
        data: formData,
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!,
          },
        ),
      );
      if (response.statusCode == 200) {
        return Future.value(unit);
      } else {
        print('Server responded with status: ${response.statusCode}');
        print('Response data: ${response.data}');
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
  Future<msg_Get_Wedd_hal> getweddingdetailsdatasourece() async {
    try {
      final response = await dio.get(
        '${BASE_URL}/api/shopper/get_my_widd',
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!,
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final msgGetWeddhal = msg_Get_Wedd_hal.fromJson(response.data);
        return msgGetWeddhal;
      } else {
        print('object ${response.statusCode}');
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
  Future<ReportStarModel> poststars_datasource(
      PostStarModle poststarModle) async {
    try {
      Response response = await dio.post(
        '$BASE_URL/api/give_star_widding',
        data: poststarModle.toMap(),
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Server responded with status: ${response.statusCode}');
        print('Response data: ${response.data}');
        ReportStarModel reportStar = ReportStarModel.fromJson(response.data);
        if (reportStar.success!) {
          print(
              'Rating submitted successfully:{ ${reportStar.message} ${reportStar.success}}');
          return reportStar;
        }
      }
      throw ServerException();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        ReportStarModel reportStar = ReportStarModel.fromJson(e.response?.data);
        print('${reportStar.success}');
        print('${reportStar.message}');
        return reportStar;
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<averageStarsModel> AverageStarswedding_datasourece(
      IdStarModel Idstarmodel) async {
    try {
      IdStarModel idStarM = IdStarModel(starId: Idstarmodel.starId);
      Response response = await dio.put(
        '$BASE_URL/api/avager_stars_widding',
        data: idStarM.toJson(),
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!
          },
        ),
      );
      if (response.statusCode == 200) {
        final averageStars = averageStarsModel.fromJson(response.data);
        return averageStars;
      }
    } catch (e) {
      print('Error occurred while get average rating: $e');
    }
    throw ServerException();
  }

  Uri _getUri(String url) {
    return Uri.parse(url);
  }
}
