// ignore_for_file: non_constant_identifier_names

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/hotel_entity.dart';

abstract class HotelRepository {
  // API methods
  Future<Either<Failure, Unit>> add_hotelInfo({required Hotel newHotel});
  Future<Either<Failure, Unit>> updata_hotelInfo({required Hotel newHotel});
  Future<Either<Failure, Unit>> updata_star_hotel({required Hotel newHotel});
  Future<Either<Failure, Unit>> addDate_stay({required Hotel newHotel});
  Future<Either<Failure, Hotel>> avareg_stars_hotel();
  Future<Either<Failure, Unit>> give_star_hotel({required Hotel newHotel});
  Future<Either<Failure, List<Hotel>>> getmyfavorite();
  Future<Either<Failure, Unit>> add_favorite({required int idUser});
  Future<Either<Failure, Unit>> deletefavorite({required Hotel newHotel});
}
