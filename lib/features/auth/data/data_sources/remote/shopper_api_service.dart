// ignore_for_file: unused_element, non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:party/features/auth/data/model/createwallet_model.dart';
import 'package:party/features/auth/data/model/paid_shopper_model.dart';
import 'package:party/features/auth/data/model/shopper_model.dart';
import 'package:party/injection_container.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/strings/constans.dart';
import '../../../../features_vendor/data/models/posts_models/post_model/getall_post_model.dart';
import '../../../domain/entities/shopper_entity.dart';
import '../../model/createchargewallet_model.dart';
import '../../model/get_Pro_shopper.dart';
import '../../model/get_location_shopper.dart';
import '../../model/getwallet_model.dart';
import '../../model/post_info_shoppper.dart';

abstract class ShopperApiService {
  Future<Unit> loginShopper({required Shopper newShopper});
  Future<Unit> updateProShopper(
      {required Shopper newShopper, required File image});
  Future<GetProShopperModel> getProShopper();
  Future<Unit> deleteShopper();
  Future<Unit> changeMyPasswordShopper({required Shopper newShopper});
  Future<Unit> changeMylocationShopper({required String location});
  Future<Unit> changeEventName({required String newEventName});
  Future<Shopper> informationDataWithEvent({required Shopper shopper});
  Future<Unit> registerShopper({required Shopper newShopper});
  Future<Unit> AddInfoShopper(
      {required PostInfoLocationShopper postInfoLocationShopper});
  Future<GetLocationShopper> getMylocation();
  Future<Unit> createShopperWallet(CreatewalletModel datapost);
  Future<Unit> chargeWallet({required CreatechargewalletModel chargewallet});
  Future<PaidShopperModel> PaidSopper();
  Future<GetwalletModel> GetWallet();
  Future<ReportGetAllPostsModle> getMyposts_datasource();
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
  Future<GetProShopperModel> getProShopper() async {
    print(di.sl.get<SharedPreferences>().getString(CACHED_Token)!);
    print('$BASE_URL/api/shopper/get_pro');
    final response = await dio.get(
      '$BASE_URL/api/shopper/get_pro',
      options: Options(
        headers: {
          'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!,
          "Content-Type": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      ),
    );
    print('object');
    print(response.data);

    if (response.statusCode == 200) {
      print('object');

      final GetProShopperModel getProShopper =
          GetProShopperModel.fromMap(response.data['data']);

      return getProShopper;
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
    try {
      final response = await dio.post("$BASE_URL/api/shopper/loginshopper",
          data: newShopper.toJson());
      print(response.data['RefreshToken']);
      print(response.data);
      if (response.statusCode == 200) {
        di.sl
            .get<SharedPreferences>()
            .setString(CACHED_Token, response.data['RefreshToken']);
        di.sl.get<SharedPreferences>().setString(
            CACHED_TYPE_SHOPPER, response.data['CACHED_TYPE_SHOPPER']);
        di.sl
            .get<SharedPreferences>()
            .setString(CACHED_ID_SHOOPER, response.data['CACHED_TYPE_SHOPPER']);
        di.sl.get<SharedPreferences>().setString(
            CACHED_TYPE_SHOPPER, response.data['shopper']['event_type']);
        di.sl
            .get<SharedPreferences>()
            .setString(CACHED_ID_SHOOPER, response.data['shopper']['_id']);
        di.sl
            .get<SharedPreferences>()
            .setBool(CACHED_IS_Vendor, response.data['shopper']['is_shopper']);
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> registerShopper({required Shopper newShopper}) async {
    try {
      final response = await dio.post("$BASE_URL/api/shopper/registershopper",
          data: newShopper.toJson());
      print(response.data['RefreshToken']);
      print(response.data['shopper']['event_type']);
      if (response.statusCode == 200) {
        di.sl
            .get<SharedPreferences>()
            .setString(CACHED_Token, response.data['RefreshToken']);
        di.sl.get<SharedPreferences>().setString(
            CACHED_TYPE_SHOPPER, response.data['shopper']['event_type']);
        di.sl
            .get<SharedPreferences>()
            .setString(CACHED_ID_SHOOPER, response.data['shopper']['_id']);
        di.sl
            .get<SharedPreferences>()
            .setBool(CACHED_IS_Vendor, response.data['shopper']['is_shopper']);
        return Future.value(unit);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateProShopper(
      {required Shopper newShopper, required File image}) async {
    final request = http.MultipartRequest(
        'POST', _getUri('$BASE_URL/api/shopper/data_with_event'));
    request.headers['token'] =
        di.sl.get<SharedPreferences>().getString(CACHED_Token)!;

    final file = File(image.path);
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      image.path,
      filename: file.path.split('/').last,
      contentType: MediaType('image', 'png'),
    ));

    request.fields.addAll({
      'event_name': newShopper.event_type!,
      'location1': newShopper.location!,
      'location2': newShopper.is_verified!.toString(),
      'city': newShopper.email!
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
    // final response =
    //     await dio.post("$BASE_URL/api/shopper/data_with_event", data: newShopper.toJson());

    // if (response.statusCode == 200) {
    //   return Future.value(unit);
    // } else {
    //   throw ServerException();
    // }
  }

  Uri _getUri(String url) {
    return Uri.parse(url);
  }

  @override
  Future<Unit> AddInfoShopper(
      {required PostInfoLocationShopper postInfoLocationShopper}) async {
    final request = http.MultipartRequest(
        'POST', _getUri('$BASE_URL/api/shopper/data_with_event'));
    request.headers['token'] =
        di.sl.get<SharedPreferences>().getString(CACHED_Token)!;

    final file = File(postInfoLocationShopper.image.path);
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      postInfoLocationShopper.image.path,
      filename: file.path.split('/').last,
      contentType: MediaType('image', 'png'),
    ));

    request.fields.addAll({
      'event_name': postInfoLocationShopper.Name,
      'location1': postInfoLocationShopper.location1.toString(),
      'location2': postInfoLocationShopper.location2.toString(),
      'city': postInfoLocationShopper.city
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
  Future<Unit> createShopperWallet(CreatewalletModel datapost) async {
    try {
      final response = await dio.post(
        '$BASE_URL/api/shopper/create_Walte',
        data: datapost.toJson(),
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!,
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
        ),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        final response = await dio.get(
          '$BASE_URL/api/shopper/getMywallet',
          options: Options(
            headers: {
              'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!,
              "Content-Type": "application/json",
              "Access-Control_Allow_Origin": "*"
            },
          ),
        );

        di.sl
            .get<SharedPreferences>()
            .setString(CACHED_ID_Wallet, response.data['data']);
        print('Response data: ${response.data}');
        print('Response data: ${response.data['data']}');
        return Future.value(unit);
      } else {
        print('Response data: ${response.data}');
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
  Future<Unit> chargeWallet(
      {required CreatechargewalletModel chargewallet}) async {
    try {
      final response = await dio.post(
        '$BASE_URL/api/shopper/create_recharge',
        data: chargewallet.toJson(),
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!,
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Response data: ${response.data}');
        return Future.value(unit);
      } else {
        print('Server responded with status: ${response.statusCode}');
        print('Response data: ${response.data}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error! Response data: ${e.response!.data}');
        print('Dio error! Status code: ${e.response?.statusCode}');
      } else {
        print('Dio error! Message: ${e.message}');
      }
    }
    return Future.value(unit);
  }

  @override
  Future<PaidShopperModel> PaidSopper() async {
    print(di.sl.get<SharedPreferences>().getString(CACHED_Token)!);
    try {
      final response = await dio.put(
        '$BASE_URL/api/shopper/paid_month_shopper',
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!,
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
        ),
      );
      if (response.statusCode == 200) {
        final msgGetWeddhal = PaidShopperModel.fromJson(response.data);
        di.sl
            .get<SharedPreferences>()
            .setString(CACHED_Token, msgGetWeddhal.refreshtoken!);
        print('Response data: ${response.data}');
        return msgGetWeddhal;
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
  Future<GetwalletModel> GetWallet() async {
    try {
      final response = await dio.get(
        '$BASE_URL/api/shopper/getMywallet',
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!,
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
        ),
      );
      if (response.statusCode == 200) {
        final msgGetWeddhal = GetwalletModel.fromJson(response.data);
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
  Future<ReportGetAllPostsModle> getMyposts_datasource() async {
    try {
      final response = await dio.get(
        '$BASE_URL/api/shopper/getMyPosts',
        options: Options(
          headers: {
            'token': di.sl.get<SharedPreferences>().getString(CACHED_Token)!,
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
        ),
      );
      if (response.statusCode == 200) {
        // final decodedJson = jsonDecode(response.data);
        final msgGetWeddhal = ReportGetAllPostsModle.fromJson(response.data);
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
}
