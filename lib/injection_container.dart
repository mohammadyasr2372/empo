import 'package:dio/dio.dart';
import 'package:party/features/auth/data/data_sources/local/user_local_data.dart';
import 'package:party/features/auth/data/data_sources/remote/user_api_service.dart';
import 'package:party/features/auth/data/repository/user_repository_impl.dart';
import 'package:party/features/auth/domain/repository/user_repository.dart';
import 'package:party/features/auth/domain/usecase/user.dart';
import 'package:party/features/auth/presentation/bloc/get_user/get_user_bloc.dart';
import 'package:party/features/auth/presentation/bloc/post_put_delet_user/post_put_delet_user_bloc.dart';
import 'package:party/features/auth/presentation/bloc/shopper/bloc/shopper_bloc.dart';
import 'package:party/features/hotel/data/data_sources/remote/hotel_api_service.dart';
import 'package:party/features/hotel/data/data_sources/remote/room_api_service.dart';
import 'package:party/features/hotel/data/data_sources/remote/widd_api_service.dart';

import 'core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/data/data_sources/local/shopper_local_data.dart';
import 'features/auth/data/data_sources/remote/shopper_api_service.dart';
import 'features/auth/data/repository/shopper_repository_impl.dart';
import 'features/auth/domain/repository/shopper_repository.dart';
import 'features/auth/domain/usecase/shopper.dart';
import 'features/auth/presentation/bloc/post_put_delet_shopper/post_put_delet_shopper_bloc.dart';
import 'features/features_vendor/data/data_source/wedding_data_source/weddingHallDataSource.dart';
import 'features/hotel/presentation/bloc/get_hotel/get_hotel_bloc.dart';
import 'features/hotel/presentation/bloc/get_room/get_room_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => GetUserBloc(getProUserUseCase: sl()));
  sl.registerFactory(() => GetHotelBloc());
  sl.registerFactory(() => ShopperBloc());
  sl.registerFactory(() => GetRoomBloc());
  sl.registerFactory(() => PostPutDeletUserBloc(
      loginUserUseCase: sl(),
      registerUserUseCase: sl(),
      updataUserUseCase: sl(),
      deleteUserUseCase: sl(),
      changeMyPasswordUserUseCase: sl()));

// sl.registerFactory(() => GetShopperBloc(getProShopperUseCase: sl()));
  sl.registerFactory(() => PostPutDeletShopperBloc(
      loginShopperUseCase: sl(),
      registerShopperUseCase: sl(),
      updataShopperUseCase: sl(),
      deleteShopperUseCase: sl(),
      changeMyPasswordShopperUseCase: sl()));

// Usecases

  sl.registerLazySingleton(() => GetProUserUseCase(sl()));
  sl.registerLazySingleton(() => LoginUserUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUserUseCase(sl()));
  sl.registerLazySingleton(() => UpdataUserUseCase(sl()));
  sl.registerLazySingleton(() => DeleteUserUseCase(sl()));
  sl.registerLazySingleton(() => ChangeMyPasswordUserUseCase(sl()));

  sl.registerLazySingleton(() => GetProShopperUseCase(sl()));
  sl.registerLazySingleton(() => LoginShopperUseCase(sl()));
  sl.registerLazySingleton(() => RegisterShopperUseCase(sl()));
  sl.registerLazySingleton(() => UpdataShopperUseCase(sl()));
  sl.registerLazySingleton(() => DeleteShopperUseCase(sl()));
  sl.registerLazySingleton(() => ChangeMyPasswordShopperUseCase(sl()));

// Repository

  sl.registerLazySingleton<UserRepository>(() => UsersRepositoryImpl(
      userApiService: sl(), userLocalData: sl(), networkInfo: sl()));

  sl.registerLazySingleton<ShopperRepository>(() => ShopperRepositoryImpl(
      shopperApiService: sl(), shopperLocalData: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<UserApiService>(() => UserApiServiceIpml(dio: sl()));
  sl.registerLazySingleton<UserLocalData>(() => UserLocalDataImpl());

  sl.registerLazySingleton<ShopperApiService>(
      () => ShopperApiServiceIpml(dio: sl()));
  sl.registerLazySingleton<ShopperLocalData>(() => ShopperLocalDataImpl());

  sl.registerLazySingleton<HotelApiService>(
      () => HotelApiServiceIpml(dio: sl()));
  sl.registerLazySingleton<RoomApiService>(() => RoomApiServiceIpml(dio: sl()));
  sl.registerLazySingleton<WiddApiService>(() => WiddApiServiceIpml(dio: sl()));
  sl.registerLazySingleton<Weddinghalldatasource>(
      () => WeddinghalldatasourceImpl(dio: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External

  sl.registerSingleton(await SharedPreferences.getInstance());
  sl.registerFactory(() => DateTime.now());
  sl.registerSingleton<Dio>(Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
