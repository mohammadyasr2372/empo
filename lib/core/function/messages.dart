import 'package:dartz/dartz.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';
import '../network/network_info.dart';

typedef Future<Unit> FunctionUseMassege();

Future<Either<Failure, Unit>> getMessage(
    NetworkInfo networkInfo, FunctionUseMassege functionUseMassege) async {
  if (await networkInfo.isConnected) {
    try {
      await functionUseMassege();
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  } else {
    return Left(OfflineFailure());
  }
}
