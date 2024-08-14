import 'package:dio/dio.dart';
import 'package:party/core/strings/constans.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../injection_container.dart' as di;
import '../../models/restaurant_model/getdetails_restorant/getinforestorant.dart';
import '../../models/restaurant_model/getfood.dart';

abstract class ResturantDatasource {
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
}
