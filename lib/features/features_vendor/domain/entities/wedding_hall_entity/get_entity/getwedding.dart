import 'package:equatable/equatable.dart';

class ReportGetEntity extends Equatable{
  final bool? success;
  final GetDataWiddingEntity? dataWidding;
  ReportGetEntity({
    required this.success,
    required this.dataWidding,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetDataWiddingEntity extends Equatable{
  final String? id;
  final int? bookprice;
  final int? capacity;
  final List<ImagewidEntity> imagewids;
  final int? personbook;
  final int? capacityMin;
  final int? pricetotel;
  final bool? isBooked;
  final List<String> shopperId;
  final List<dynamic> imagehospit;
  final DateTime? createdAt;
  final int? v;
  GetDataWiddingEntity({
    required this.id,
    required this.bookprice,
    required this.capacity,
    required this.imagewids,
    required this.personbook,
    required this.capacityMin,
    required this.pricetotel,
    required this.isBooked,
    required this.shopperId,
    required this.imagehospit,
    required this.createdAt,
    required this.v,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ImagewidEntity extends Equatable{
  final String? id;
  ImagewidEntity({
    required this.id,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
