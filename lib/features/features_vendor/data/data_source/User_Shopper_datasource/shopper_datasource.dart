// // ignore_for_file: non_constant_identifier_names, unused_import, avoid_print

// import 'package:dio/dio.dart';
// import 'package:party/core/strings/constans.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../../../core/error/exceptions.dart';
// import '../../../../../injection_container.dart' as di;
// import '../../../../auth/data/model/createchargewallet_model.dart';
// import '../../../../auth/data/model/createwallet_model.dart';
// import '../../../../auth/data/model/get_createwallet_model.dart';
// import '../../../../auth/data/model/getwallet_model.dart';
// import '../../models/posts_models/post_model/getall_post_model.dart';
// import '../../models/shopper_model/paid_shopper_model.dart';
// import '../../models/user_model/wallat/createchargewallet_model.dart';
// import '../../models/user_model/wallat/createwallet_model.dart';
// import '../../models/user_model/wallat/getwallet_model.dart';
// import '../../models/user_model/wallat/stutes_wallet_model.dart';

// abstract class ShopperDatasource {
//   Future<GetCreatewalletModel> createShopperWallet(CreatewalletModel datapost);
//   Future<void> chargeWallet(CreatechargewalletModel chargewallet);
//   Future<PaidShopperModel> PaidSopper();
//   Future<GetwalletModel> GetWallet();
//   Future<ReportGetAllPostsModle> getMyposts_datasource();
// }

// String token = di.sl.get<SharedPreferences>().getString(CACHED_Token)!;

// class ShopperDatasourceImp implements ShopperDatasource {
//   final Dio dio;
//   ShopperDatasourceImp({
//     required this.dio,
//   });
//   @override
//   Future<GetCreatewalletModel> createShopperWallet(
//       CreatewalletModel datapost) async {
//     try {
//       final response = await dio.post(
//         '$BASE_URL/api/shopper/create_Walte',
//         data: datapost.toJson(),
//         options: Options(
//           headers: {
//             'token': token,
//             "Content-Type": "application/json",
//             "Access-Control_Allow_Origin": "*"
//           },
//         ),
//       );
//       if (response.statusCode == 201 || response.statusCode == 200) {
//         final msgGetWeddhal = GetCreatewalletModel.fromJson(response.data);
//         print('Response data: ${response.data}');
//         return msgGetWeddhal;
//       } else {
//         print('Response data: ${response.data}');

//         print('Server responded with status: ${response.statusCode}');
//         print('Response data: ${response.data}');
//         throw ServerException();
//       }
//     } on DioException catch (e) {
//       if (e.response != null) {
//         print('Dio error! Response data: ${e.response!.data}');
//         print('Dio error! Status code: ${e.response?.statusCode}');
//       } else {
//         print('Dio error! Message: ${e.message}');
//       }
//       throw ServerException();
//     }
//   }

//   @override
//   Future<void> chargeWallet(CreatechargewalletModel chargewallet) async {
//     try {
//       final response = await dio.post(
//         '$BASE_URL/api/shopper/create_recharge',
//         data: chargewallet.toJson(),
//         options: Options(
//           headers: {
//             'token': token,
//             "Content-Type": "application/json",
//             "Access-Control_Allow_Origin": "*"
//           },
//         ),
//       );

//       if (response.statusCode == 200) {
//         print('Response data: ${response.data}');
//       } else {
//         print('Server responded with status: ${response.statusCode}');
//         print('Response data: ${response.data}');
//       }
//     } on DioException catch (e) {
//       if (e.response != null) {
//         print('Dio error! Response data: ${e.response!.data}');
//         print('Dio error! Status code: ${e.response?.statusCode}');
//       } else {
//         print('Dio error! Message: ${e.message}');
//       }
//     }
//   }

//   @override
//   Future<PaidShopperModel> PaidSopper() async {
//     try {
//       final response = await dio.put(
//         '$BASE_URL/api/shopper/paid_month_shopper',
//         options: Options(
//           headers: {
//             'token': token,
//             "Content-Type": "application/json",
//             "Access-Control_Allow_Origin": "*"
//           },
//         ),
//       );
//       if (response.statusCode == 201) {
//         final msgGetWeddhal = PaidShopperModel.fromJson(response.data);
//         print('Response data: ${response.data}');
//         return msgGetWeddhal;
//       } else {
//         print('Server responded with status: ${response.statusCode}');
//         print('Response data: ${response.data}');
//         throw ServerException();
//       }
//     } on DioException catch (e) {
//       if (e.response != null) {
//         print('Dio error! Response data: ${e.response!.data}');
//         print('Dio error! Status code: ${e.response?.statusCode}');
//       } else {
//         print('Dio error! Message: ${e.message}');
//       }
//       throw ServerException();
//     }
//   }

//   @override
//   Future<GetwalletModel> GetWallet() async {
//     try {
//       final response = await dio.get(
//         '$BASE_URL/api/shopper/getMywallet',
//         options: Options(
//           headers: {
//             'token': token,
//             "Content-Type": "application/json",
//             "Access-Control_Allow_Origin": "*"
//           },
//         ),
//       );
//       if (response.statusCode == 200) {
//         final msgGetWeddhal = GetwalletModel.fromJson(response.data);
//         return msgGetWeddhal;
//       } else {
//         throw ServerException();
//       }
//     } on DioException catch (e) {
//       if (e.response != null) {
//         print('Dio error! Response data: ${e.response!.data}');
//         print('Dio error! Status code: ${e.response?.statusCode}');
//       } else {
//         print('Dio error! Message: ${e.message}');
//       }
//       throw ServerException();
//     }
//   }

//   @override
//   Future<ReportGetAllPostsModle> getMyposts_datasource() async {
//     try {
//       final response = await dio.get(
//         '$BASE_URL/api/shopper/getMyPosts',
//         options: Options(
//           headers: {
//             'token': token,
//             "Content-Type": "application/json",
//             "Access-Control_Allow_Origin": "*"
//           },
//         ),
//       );
//       if (response.statusCode == 200) {
//         // final decodedJson = jsonDecode(response.data);
//         final msgGetWeddhal = ReportGetAllPostsModle.fromJson(response.data);
//         return msgGetWeddhal;
//       } else {
//         throw ServerException();
//       }
//     } on DioException catch (e) {
//       if (e.response != null) {
//         print('Dio error! Response data: ${e.response!.data}');
//         print('Dio error! Status code: ${e.response?.statusCode}');
//       } else {
//         print('Dio error! Message: ${e.message}');
//       }
//       throw ServerException();
//     }
//   }
// }
