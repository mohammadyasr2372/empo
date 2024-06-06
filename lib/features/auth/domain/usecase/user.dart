import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repository/user_repository.dart';

class LoginUserUseCase {
  final UserRepository _userRepository;

  LoginUserUseCase(this._userRepository);

  Future<Either<Failure, Unit>> call(User user) {
    return _userRepository.login(newUser: user);
  }
}

class RegisterUserUseCase {
  final UserRepository _userRepository;

  RegisterUserUseCase(this._userRepository);

  Future<Either<Failure, Unit>> call(User user) {
    return _userRepository.register(newUser:user);
  }
}

class DeleteUserUseCase {
  final UserRepository _userRepository;

  DeleteUserUseCase(this._userRepository);

  Future<Either<Failure, Unit>> call() {
    return _userRepository.deleteUser();
  }
}

class UpdataUserUseCase {
  final UserRepository _userRepository;

  UpdataUserUseCase(this._userRepository);

  Future<Either<Failure, Unit>> call(User user) {
    return _userRepository.updataProUser(newUser:user);
  }
}

class GetProUserUseCase {
  final UserRepository _userRepository;

  GetProUserUseCase(this._userRepository);

  Future<Either<Failure, User>> call() {
    return _userRepository.getPro();
  }
}

class ChangeMyPasswordUserUseCase {
  final UserRepository _userRepository;

  ChangeMyPasswordUserUseCase(this._userRepository);

  Future<Either<Failure, Unit>> call(User user) {
    return _userRepository.changeMyPassword(newUser:user);
  }
}
