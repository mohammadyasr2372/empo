import 'package:dartz/dartz.dart';
import 'package:party/core/error/failures.dart';

import '../../data/model/get_location_shopper.dart';
import '../entities/shopper_entity.dart';

abstract class ShopperRepository {
  // API methods
  Future<Either<Failure, Unit>> loginShopper(
      {required Shopper newShopper});
  Future<Either<Failure, Unit>> updateProShopper(
      {required Shopper newShopper});
  Future<Either<Failure, Shopper>> getProShopper();
  Future<Either<Failure, Unit>> deleteShopper();
  Future<Either<Failure, Unit>> changeMyPasswordShopper(
      {required Shopper newShopper});
  Future<Either<Failure, Unit>> changeMylocationShopper(
      {required String location});
  Future<Either<Failure, Unit>> changeEventName({required String newEventName});
  Future<Either<Failure, Shopper>> informationDataWithEvent(
      {required Shopper shopper});
  Future<Either<Failure, Unit>> registerShopper(
      {required Shopper newShopper});
  Future<Either<Failure,  GetLocationShopper>> getMylocation();
}
