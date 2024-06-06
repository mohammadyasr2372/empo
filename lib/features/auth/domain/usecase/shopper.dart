import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/get_location_shopper.dart';
import '../entities/shopper_entity.dart';
import '../repository/shopper_repository.dart';

class LoginShopperUseCase {
  final ShopperRepository _shopperRepository;

  LoginShopperUseCase(this._shopperRepository);

  Future<Either<Failure, Unit>> call(Shopper shopper) {
    return _shopperRepository.loginShopper(newShopper: shopper);
  }
}

class RegisterShopperUseCase {
  final ShopperRepository _shopperRepository;

  RegisterShopperUseCase(this._shopperRepository);

  Future<Either<Failure, Unit>> call(Shopper shopper) {
    return _shopperRepository.registerShopper(newShopper: shopper);
  }
}

class DeleteShopperUseCase {
  final ShopperRepository _shopperRepository;

  DeleteShopperUseCase(this._shopperRepository);

  Future<Either<Failure, Unit>> call() {
    return _shopperRepository.deleteShopper();
  }
}

class UpdataShopperUseCase {
  final ShopperRepository _shopperRepository;

  UpdataShopperUseCase(this._shopperRepository);

  Future<Either<Failure, Unit>> call(Shopper shopper) {
    return _shopperRepository.updateProShopper(newShopper: shopper);
  }
}

class GetProShopperUseCase {
  final ShopperRepository _shopperRepository;

  GetProShopperUseCase(this._shopperRepository);

  Future<Either<Failure, Shopper>> call() {
    return _shopperRepository.getProShopper();
  }
}

class ChangeMyPasswordShopperUseCase {
  final ShopperRepository _shopperRepository;

  ChangeMyPasswordShopperUseCase(this._shopperRepository);

  Future<Either<Failure, Unit>> call(Shopper shopper) {
    return _shopperRepository.changeMyPasswordShopper(newShopper: shopper);
  }
}

class ChangeMylocationShopperUseCase {
  final ShopperRepository _shopperRepository;

  ChangeMylocationShopperUseCase(this._shopperRepository);

  Future<Either<Failure, Unit>> call(String location) {
    return _shopperRepository.changeMylocationShopper(location: location);
  }
}

class ChangeEventNameShopperUseCase {
  final ShopperRepository _shopperRepository;

  ChangeEventNameShopperUseCase(this._shopperRepository);

  Future<Either<Failure, Unit>> call(String newEventName) {
    return _shopperRepository.changeEventName(newEventName: newEventName);
  }
}

class InformationDataWithEventUseCase {
  final ShopperRepository _shopperRepository;

  InformationDataWithEventUseCase(this._shopperRepository);

  Future<Either<Failure, Shopper>> call(Shopper shopper) {
    return _shopperRepository.informationDataWithEvent(shopper: shopper);
  }
}

class GetLocationShopperUseCase {
  final ShopperRepository _shopperRepository;

  GetLocationShopperUseCase(this._shopperRepository);

  Future<Either<Failure,  GetLocationShopper>> call() {
    return _shopperRepository.getMylocation();
  }
}
