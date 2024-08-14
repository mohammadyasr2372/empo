import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../entities/wedding_hall_entity/get_entity/averagestar_entity.dart';
import '../../entities/wedding_hall_entity/get_entity/getwedding.dart';
import '../../entities/wedding_hall_entity/post_entity/poststar.dart';
import '../../entities/wedding_hall_entity/post_entity/postwedding.dart';

abstract class WeddingHallRepository {
  Future<Either<Failure, Unit>> addweddingdetails(
    int bookprice,
    int capacity,
    int personbook,
    int capacityMin,
    List<File> imagewids,
    // DatawiddPOstEntity PostEntity,
  );
  Future<Either<Failure, Unit>> updateweddingdetails(
    // int bookprice,
    // int capacity,
    // int personbook,
    // int capacityMin,
    // List<File> imagewids,
    DatawiddPOstEntity PostEntity,
  );

  Future<Either<Failure, ReportGetEntity>> getweddingdetails();
  Future<Either<Failure, averageStarsEntity>> getAverageStarwedding(
      IdStarEntity IdStarE);

  Future<Either<Failure, Unit>> add_image_hospit(
    List<File> imagehospit,
  );
  Future<Either<Failure, ReportStar>> Post_Star(PostStarEntity postStarEntity);
}
