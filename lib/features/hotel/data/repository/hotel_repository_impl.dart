// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';

import 'package:party/core/error/failures.dart';

import 'package:party/features/hotel/domain/entities/hotel_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/function/messages.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repository/hotel_repository.dart';
import '../data_sources/remote/hotel_api_service.dart';

class HotelsRepositoryImpl implements HotelRepository {
  final HotelApiService hotelApiService;
  // final HotelLocalData hotelLocalData;

  final NetworkInfo networkInfo;
  HotelsRepositoryImpl(
      {required this.hotelApiService,
      // required this.hotelLocalData,
      required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> addDate_stay({required Hotel newHotel}) async {
    return await getMessage(networkInfo, () {
      return hotelApiService.addDate_stay(newHotel: newHotel);
    });
  }

  @override
  Future<Either<Failure, Unit>> add_favorite({required int idUser}) async {
    return await getMessage(networkInfo, () {
      return hotelApiService.add_favorite(idUser: idUser);
    });
  }

  @override
  Future<Either<Failure, Unit>> add_hotelInfo({required Hotel newHotel}) async {
    return await getMessage(networkInfo, () {
      return hotelApiService.add_hotelInfo(newHotel: newHotel);
    });
  }

  @override
  Future<Either<Failure, Hotel>> avareg_stars_hotel() async {
    try {
      final remoteHotel = await hotelApiService.avareg_stars_hotel();
      // userLocalData.cacheUsers(remoteHotel as UserModel);
      return Right(remoteHotel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletefavorite(
      {required Hotel newHotel}) async {
    return await getMessage(networkInfo, () {
      return hotelApiService.deletefavorite(newHotel: newHotel);
    });
  }

  @override
  Future<Either<Failure, List<Hotel>>> getmyfavorite() async {
    try {
      final remoteHotel = await hotelApiService.getmyfavorite();
      // userLocalData.cacheUsers(remoteHotel as UserModel);
      return Right(remoteHotel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> give_star_hotel(
      {required Hotel newHotel}) async {
    return await getMessage(networkInfo, () {
      return hotelApiService.give_star_hotel(newHotel: newHotel);
    });
  }

  @override
  Future<Either<Failure, Unit>> updata_hotelInfo(
      {required Hotel newHotel}) async {
    return await getMessage(networkInfo, () {
      return hotelApiService.updata_hotelInfo(newHotel: newHotel);
    });
  }

  @override
  Future<Either<Failure, Unit>> updata_star_hotel(
      {required Hotel newHotel}) async {
    return await getMessage(networkInfo, () {
      return hotelApiService.updata_star_hotel(newHotel: newHotel);
    });
  }
}
