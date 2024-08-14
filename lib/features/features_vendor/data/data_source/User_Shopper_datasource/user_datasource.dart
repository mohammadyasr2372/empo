// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/strings/constans.dart';
import '../../../../../injection_container.dart' as di;
import '../../../../auth/data/model/createchargewallet_model.dart';
import '../../../../auth/data/model/createwallet_model.dart';
import '../../../../auth/data/model/get_createwallet_model.dart';
import '../../../../auth/data/model/getwallet_model.dart';
import '../../models/posts_models/like_model/addlike_model.dart';
import '../../models/posts_models/like_model/deletelike_model.dart';
import '../../models/posts_models/like_model/get_counter_like_modle.dart';
import '../../models/user_model/addreport/addReport.dart';
import '../../models/user_model/booked/booked_resturant_user_model.dart';
import '../../models/user_model/booked/booked_wedding_user_model.dart';
import '../../models/user_model/booked/getBookedWedding_model.dart';
import '../../models/user_model/comment_model/commentModel.dart';
import '../../models/user_model/wallat/createchargewallet_model.dart';
import '../../models/user_model/wallat/createwallet_model.dart';
import '../../models/user_model/search_user/getcity_model.dart';
import '../../models/user_model/wallat/getwallet_model.dart';
import '../../models/user_model/search_user/search_city.dart';
import '../../models/user_model/search_user/get_shopper.dart';
import '../../models/user_model/search_user/search_price.dart';

abstract class UserDatasource {
  Future<GetcityModel> getcity_datasource();
  Future<void> Chaegrwallet(CreatechargewalletModel createchargewallet);
  Future<void> craetewallet(CreatewalletModel createwalletModel);
  Future<GetwalletModel> Getwallet_datasource();
  ///////////////////////////////////////////////////
  Future<void> bookedrsturant(
      BookedResturantUserModel bookedResturantUser, String Id);
  Future<void> bookedweddinghall(
      BookedWeddingUserModel bookedResturantUser, String Id);
  Future<GetbookedweddingModel> getbookedwedding();
////////////////////////////////////////////
  Future<SearchPrice> searchpriceUser(
    String price,
    String vendor,
  );
  Future<GetShopper> getDataShopperUser(String Id);
  Future<SearchCity> searchcity(
    String city,
  );
  Future<CommenModel> getpostcomment(String Id);
  Future<void> createcomment(String content_comment, String Id);
  Future<void> AddFavorite(String Id);

  Future<ReportAddLikeMo> addlike_d(String postId);
  Future<GetCounterLikeModle> getlike_d(String postId);
  Future<DeletelikeModel> deletelike_d(String postId);
  Future<Addreport> addreport_d(
      {required String reason,
      required String shopperId,
      required String postId});
}

String token = di.sl.get<SharedPreferences>().getString(CACHED_Token)!;

class UserDatasourceImp implements UserDatasource {
  final Dio dio;
  UserDatasourceImp({
    required this.dio,
  });

  @override
  Future<GetcityModel> getcity_datasource() async {
    try {
      final response = await dio.get(
        '$BASE_URL/api/getCitys',
        options: Options(
          headers: {'token': token},
        ),
      );
      if (response.statusCode == 200) {
        final msgGetWeddhal = GetcityModel.fromJson(response.data);
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
  Future<void> Chaegrwallet(CreatechargewalletModel createchargewallet) async {
    try {
      final response = await dio.post(
        '$BASE_URL/api/create_recharge',
        data: createchargewallet.toJson(),
        options: Options(
          headers: {
            'token': token,
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
        ),
      );
      if (response.statusCode == 201) {
        print('Response data: ${response.data}');
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
  }

  @override
  Future<GetCreatewalletModel> craetewallet(
      CreatewalletModel createwalletModel) async {
    try {
      final response = await dio.post(
        '$BASE_URL/api/create_Walte',
        data: createwalletModel.toJson(),
        options: Options(
          headers: {
            'token': token,
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
        ),
      );
      if (response.statusCode == 200) {
        final msgGetWeddhal = GetCreatewalletModel.fromJson(response.data);
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
  Future<GetwalletModel> Getwallet_datasource() async {
    try {
      final response = await dio.get(
        '$BASE_URL/api/getMywallet',
        options: Options(
          headers: {
            'token': token,
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
  Future<void> bookedrsturant(
      BookedResturantUserModel bookedResturantUser, String Id) async {
    try {
      final response = await dio.post(
        '$BASE_URL/api/addBookes_table/$Id',
        data: bookedResturantUser.toJson(),
        options: Options(
          headers: {
            'token': token,
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
        ),
      );
      if (response.statusCode == 201) {
        print('Response data: ${response.data}');
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
  }

  @override
  Future<void> bookedweddinghall(
      BookedWeddingUserModel bookedResturantUser, String Id) async {
    try {
      final response = await dio.post(
        '$BASE_URL/api/add_booked/$Id',
        data: bookedResturantUser.toJson(),
        options: Options(
          headers: {
            'token': token,
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
        ),
      );
      if (response.statusCode == 201) {
        print('Response data: ${response.data}');
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
  }

  @override
  Future<GetShopper> getDataShopperUser(String Id) async {
    try {
      final response = await dio.get(
        '$BASE_URL/api/get_shopper/$Id',
        options: Options(
          headers: {
            'token': token,
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final msgGetWeddhal = GetShopper.fromJson(response.data);
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
  Future<SearchPrice> searchpriceUser(
    String price,
    String vendor,
  ) async {
    try {
      final response = await dio.get(
        '$BASE_URL/api/search_price?price=$price&event_type=$vendor',
        options: Options(
          headers: {
            'token': token,
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final msgGetWeddhal = SearchPrice.fromJson(response.data);
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
  Future<SearchCity> searchcity(String city) async {
    try {
      final response = await dio.get(
        '$BASE_URL/api/search_citys?city=$city',
        options: Options(
          headers: {
            'token': token,
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final msgGetWeddhal = SearchCity.fromJson(response.data);
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
  Future<ReportAddLikeMo> addlike_d(String postId) async {
    // PostID_Model postID = PostID_Model(postId: postId.postId);
    var ostid = {'postId': postId};
    try {
      final response = await dio.post(
        '$BASE_URL/api/add_like',
        data: ostid,
        options: Options(
          headers: {'token': token},
        ),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        ReportAddLikeMo reportaddlike = ReportAddLikeMo.fromJson(response.data);
        print('Response data: ${response.data}');
        print('${reportaddlike.success}');
        print('${reportaddlike.message}');
        return reportaddlike;
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
  Future<GetCounterLikeModle> getlike_d(String postId) async {
    // PostID_Model postID = PostID_Model(postId: postId.postId);
    var ostid = {'postId': postId};
    try {
      final response = await dio.post(
        '$BASE_URL/api/get_conuter_like',
        data: ostid,
        options: Options(
          headers: {'token': token},
        ),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        GetCounterLikeModle reportaddlike =
            GetCounterLikeModle.fromJson(response.data);
        print('Response data: ${response.data}');
        print('${reportaddlike.success}');
        print('${reportaddlike.counterLikes}');

        return reportaddlike;
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
  Future<DeletelikeModel> deletelike_d(String postId) async {
    try {
      // DeleteLikeIdPostModel IDPOST =
      //     DeleteLikeIdPostModel(postId: postId.postId);
      var ostid = {'postId': postId};
      final response = await dio.delete(
        '$BASE_URL/api/delete_like',
        data: ostid,
        options: Options(
          headers: {
            'token': token,
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Like deleted successfully');
        final deletePost = DeletelikeModel.fromJson(response.data);
        return deletePost;
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
  Future<Addreport> addreport_d(
      {required String reason,
      required String shopperId,
      required String postId}) async {
    var report = {'reason': reason, 'shopperId': shopperId, 'postId': postId};
    try {
      final response = await dio.post(
        '$BASE_URL/api/addReport',
        data: report,
        options: Options(
          headers: {'token': token},
        ),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        Addreport reportaddlike = Addreport.fromJson(response.data);
        print('Response data: ${response.data}');
        print('${reportaddlike.success}');
        return reportaddlike;
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
  Future<void> createcomment(String content_comment, String Id) async {
    var report = {'content_comment': content_comment};
    try {
      final response = await dio.post(
        '$BASE_URL/api/addComment/$Id',
        data: report,
        options: Options(
          headers: {'token': token},
        ),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Response data: ${response.data}');
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
  Future<CommenModel> getpostcomment(String Id) async {
    try {
      final response = await dio.get(
        '$BASE_URL/api/postComments/$Id',
        queryParameters: {
          'postId': Id,
        },
        options: Options(
          headers: {
            'token': token,
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final msgGetWeddhal = CommenModel.fromJson(response.data);
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
  Future<void> AddFavorite(String Id) async {
    try {
      final response = await dio.post(
        '$BASE_URL/api/add_favoritePost/$Id',
        options: Options(
          headers: {'token': token},
        ),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Response data: ${response.data}');
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
  Future<GetbookedweddingModel> getbookedwedding() async {
    try {
      final response = await dio.get(
        '$BASE_URL/api/getMyBooked',
        options: Options(
          headers: {
            'token': token,
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final msgGetWeddhal = GetbookedweddingModel.fromJson(response.data);
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
}
