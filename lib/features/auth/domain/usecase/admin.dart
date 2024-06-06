import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/admin_entity.dart';
import '../entities/shopper_entity.dart';
import '../entities/user_entity.dart';
import '../repository/admin_repository.dart';

class GetUsersWithAdminUseCase {
  final AdminRepository _adminRepository;

  GetUsersWithAdminUseCase(this._adminRepository);

  Future<Either<Failure, List<User>>> call() {
    return _adminRepository.getUserWithAdmin();
  }
}

class GetShoppersWithAdminUseCase {
  final AdminRepository _adminRepository;

  GetShoppersWithAdminUseCase(this._adminRepository);

  Future<Either<Failure, List<Shopper>>> call() {
    return _adminRepository.getShopperWithAdmin();
  }
}

class LoginAdminUseCase {
  final AdminRepository _adminRepository;

  LoginAdminUseCase(this._adminRepository);

  Future<Either<Failure, Unit>> call(Admin admin) {
    return _adminRepository.loginAdmin(newAdmin: admin);
  }
}

class GetProAdminUseCase {
  final AdminRepository _adminRepository;

  GetProAdminUseCase(this._adminRepository);

  Future<Either<Failure, Admin>> call() {
    return _adminRepository.getProAdmin();
  }
}

class DeleteUserAdminUseCase {
  final AdminRepository _adminRepository;

  DeleteUserAdminUseCase(this._adminRepository);

  Future<Either<Failure, Unit>> call(int idUser) {
    return _adminRepository.deleteUserAdmin(idUser: idUser);
  }
}

class GetCounterUsersUseCase {
  final AdminRepository _adminRepository;

  GetCounterUsersUseCase(this._adminRepository);

  Future<Either<Failure, String>> call() {
    return _adminRepository.getCounterUsers();
  }
}

class GetCounterShoppersUseCase {
  final AdminRepository _adminRepository;

  GetCounterShoppersUseCase(this._adminRepository);

  Future<Either<Failure, String>> call() {
    return _adminRepository.getCounterShopper();
  }
}

class UpdateProAdminUseCase {
  final AdminRepository _adminRepository;

  UpdateProAdminUseCase(this._adminRepository);

  Future<Either<Failure, Unit>> call(Admin admin) {
    return _adminRepository.updateProAdmin(newAdmin: admin);
  }
}

class ChangeMyPasswordAdminUseCase {
  final AdminRepository _adminRepository;

  ChangeMyPasswordAdminUseCase(this._adminRepository);

  Future<Either<Failure, Unit>> call(Admin admin) {
    return _adminRepository.changeMyPasswordAdmin(newAdmin: admin);
  }
}

class GetAllUsersUseCase {
  final AdminRepository _adminRepository;

  GetAllUsersUseCase(this._adminRepository);

  Future<Either<Failure, List<User>>> call() {
    return _adminRepository.getAllUsers();
  }
}

class GetAllShoppersUseCase {
  final AdminRepository _adminRepository;

  GetAllShoppersUseCase(this._adminRepository);

  Future<Either<Failure, List<Shopper>>> call() {
    return _adminRepository.getAllShoppers();
  }
}

class SearchShoppersUseCase {
  final AdminRepository _adminRepository;

  SearchShoppersUseCase(this._adminRepository);

  Future<Either<Failure, List<Shopper>>> call(String eventName) {
    return _adminRepository.searchShoppers(event_name: eventName);
  }
}

class SearchUsersUseCase {
  final AdminRepository _adminRepository;

  SearchUsersUseCase(this._adminRepository);

  Future<Either<Failure, List<User>>> call(String eventName) {
    return _adminRepository.searchUser(event_name: eventName);
  }
}
