import 'dart:io';

import 'package:equatable/equatable.dart';

class ReportPostEntity extends Equatable {
  ReportPostEntity({
    required this.success,
    required this.message,
    required this.datawid,
  });
  final bool? success;
  final String? message;
  final DatawiddPOstEntity? datawid;

  @override
  List<Object?> get props => [success,message,datawid];
}

class DatawiddPOstEntity extends Equatable {
  final int? bookprice;
  final int? capacity;
  final List<ImagewidEntity> imagewids;
  final int? personbook;
  final int? capacityMin;
  DatawiddPOstEntity({
    required this.bookprice,
    required this.capacity,
    required this.imagewids,
    required this.personbook,
    required this.capacityMin,
  });

  @override
  List<Object?> get props => [bookprice, capacity, imagewids,personbook,capacityMin];
}

class ImagewidEntity extends Equatable {
  final File? id;
  ImagewidEntity({
    required this.id,
  });

  @override
  // TODO:  props
  List<Object?> get props =>[id];
}
