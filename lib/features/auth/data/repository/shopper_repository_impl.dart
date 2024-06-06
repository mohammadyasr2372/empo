import 'package:dartz/dartz.dart';
import 'package:party/core/error/failures.dart';
import 'package:party/features/auth/data/model/get_location_shopper.dart';
import 'package:party/features/auth/domain/entities/shopper_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/function/messages.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repository/shopper_repository.dart';
import '../data_sources/local/shopper_local_data.dart';
import '../data_sources/remote/shopper_api_service.dart';
import '../model/shopper_model.dart';

class ShopperRepositoryImpl implements ShopperRepository {
  final ShopperApiService shopperApiService;
  final ShopperLocalData shopperLocalData;
  final NetworkInfo networkInfo;
  ShopperRepositoryImpl(
      {required this.shopperApiService,
      required this.shopperLocalData,
      required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> changeEventName(
      {required String newEventName}) async {
    return await getMessage(networkInfo, () {
      return shopperApiService.changeEventName(newEventName: newEventName);
    });
  }

  @override
  Future<Either<Failure, Unit>> changeMyPasswordShopper(
      {required Shopper newShopper}) async {
    return await getMessage(networkInfo, () {
      return shopperApiService.updateProShopper(newShopper: newShopper);
    });
  }

  @override
  Future<Either<Failure, Unit>> changeMylocationShopper(
      {required String location}) async {
    return await getMessage(networkInfo, () {
      return shopperApiService.changeMylocationShopper(location: location);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteShopper() async {
    return await getMessage(networkInfo, () {
      return shopperApiService.deleteShopper();
    });
  }

  @override
  Future<Either<Failure, GetLocationShopper>> getMylocation() async {
    if (await networkInfo.isConnected) {
      try {
        final remotelocation = await shopperApiService.getMylocation();
        return Right(remotelocation);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Shopper>> getProShopper() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteShopper = await shopperApiService.getProShopper();
        shopperLocalData.cacheShoppers(remoteShopper as ShopperModel);
        return Right(remoteShopper);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localShopper = await shopperLocalData.getCachedProShopper();
        return Right(localShopper);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Shopper>> informationDataWithEvent(
      {required Shopper shopper}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteShopper =
            await shopperApiService.informationDataWithEvent(shopper: shopper);
        return Right(remoteShopper);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> loginShopper(
      {required Shopper newShopper}) async {
    return await getMessage(networkInfo, () {
      return shopperApiService.updateProShopper(newShopper: newShopper);
    });
  }

  @override
  Future<Either<Failure, Unit>> registerShopper(
      {required Shopper newShopper}) async {
    return await getMessage(networkInfo, () {
      return shopperApiService.updateProShopper(newShopper: newShopper);
    });
  }

  @override
  Future<Either<Failure, Unit>> updateProShopper(
      {required Shopper newShopper}) async {
    return await getMessage(networkInfo, () {
      return shopperApiService.updateProShopper(newShopper: newShopper);
    });
  }
}
