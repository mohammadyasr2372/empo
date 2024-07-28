import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/hotel_entity.dart';
import '../repository/hotel_repository.dart';

class AddHotelInfoUseCase {
  final HotelRepository _hotelRepository;

  AddHotelInfoUseCase(this._hotelRepository);

  Future<Either<Failure, Unit>> call(Hotel hotel) {
    return _hotelRepository.add_hotelInfo(newHotel: hotel);
  }
}

class UpdateHotelInfoUseCase {
  final HotelRepository _hotelRepository;

  UpdateHotelInfoUseCase(this._hotelRepository);

  Future<Either<Failure, Unit>> call(Hotel hotel) {
    return _hotelRepository.updata_hotelInfo(newHotel: hotel);
  }
}

class UpdataStarHotelUseCase {
  final HotelRepository _hotelRepository;

  UpdataStarHotelUseCase(this._hotelRepository);

  Future<Either<Failure, Unit>> call(Hotel hotel) {
    return _hotelRepository.updata_star_hotel(newHotel: hotel);
  }
}

class AddDateStayUseCase {
  final HotelRepository _hotelRepository;

  AddDateStayUseCase(this._hotelRepository);

  Future<Either<Failure, Unit>> call(Hotel hotel) {
    return _hotelRepository.addDate_stay(newHotel: hotel);
  }
}

class GiveStarHotelUseCase {
  final HotelRepository _hotelRepository;

  GiveStarHotelUseCase(this._hotelRepository);

  Future<Either<Failure, Unit>> call(Hotel hotel) {
    return _hotelRepository.give_star_hotel(newHotel: hotel);
  }
}

class AddFavoriteUseCase {
  final HotelRepository _hotelRepository;

  AddFavoriteUseCase(this._hotelRepository);

  Future<Either<Failure, Unit>> call(int id) {
    return _hotelRepository.add_favorite(idUser: id);
  }
}

class DeleteFavoriteUseCase {
  final HotelRepository _hotelRepository;

  DeleteFavoriteUseCase(this._hotelRepository);

  Future<Either<Failure, Unit>> call(Hotel hotel) {
    return _hotelRepository.deletefavorite(newHotel: hotel);
  }
}

class AvaregStarsHotelUseCase {
  final HotelRepository _hotelRepository;

  AvaregStarsHotelUseCase(this._hotelRepository);

  Future<Either<Failure, Hotel>> call() {
    return _hotelRepository.avareg_stars_hotel();
  }
}

class GetMyFavoriteUseCase {
  final HotelRepository _hotelRepository;

  GetMyFavoriteUseCase(this._hotelRepository);

  Future<Either<Failure, List<Hotel>>> call() {
    return _hotelRepository.getmyfavorite();
  }
}
