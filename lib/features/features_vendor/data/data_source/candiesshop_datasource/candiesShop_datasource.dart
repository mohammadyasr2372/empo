import 'package:dio/dio.dart';
import 'package:party/core/strings/constans.dart';
import 'package:party/injection_container.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/exceptions.dart';
import '../../models/candeisshop_model/getSweet.dart';
import '../../models/candeisshop_model/getcandyShop_model.dart';

abstract class CandiesshopDatasource {
  Future<GetcandyshopModel> getCandiesShop_datasourece();
  Future<Getsweet> getSweet_datasourece(String ID);
}

String token = di.sl.get<SharedPreferences>().getString(CACHED_Token)!;

class CandiesshopDatasourceImpl implements CandiesshopDatasource {
  final Dio dio;
  CandiesshopDatasourceImpl({
    required this.dio,
  });

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
}
