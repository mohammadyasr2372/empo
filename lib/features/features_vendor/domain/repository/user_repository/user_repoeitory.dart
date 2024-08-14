// ignore_for_file: unused_import

import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../entities/user_entity/createwallatuser.dart';
import '../../entities/user_entity/getcity_entity.dart';

abstract class UserRepoeitory {
  Future<Either<Failure, GetcityEntity>> getcity();
  // Future<Either<Failure, Createwallatuser>> craetewallet();
}
