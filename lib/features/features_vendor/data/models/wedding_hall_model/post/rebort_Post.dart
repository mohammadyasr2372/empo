import 'dart:io';

import '../../../../domain/entities/wedding_hall_entity/post_entity/postwedding.dart';

class WeddingPOst extends ReportPostEntity {
  WeddingPOst({
    required this.success,
    required this.message,
    required this.datawidd,
  }) : super(success: success, message: message, datawid: datawidd);

  final bool? success;
  final String? message;
  final DatawiddPOst? datawidd;

  factory WeddingPOst.fromJson(Map<String, dynamic> json) {
    return WeddingPOst(
      success: json["success"],
      message: json["message"],
      datawidd: json["Datawidd"] == null
          ? null
          : DatawiddPOst.fromJson(json["Datawidd"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "Datawidd": datawidd?.toJson(),
      };
}

class DatawiddPOst extends DatawiddPOstEntity {
  DatawiddPOst({
    required this.bookprice,
    required this.capacity,
    required this.imagewids,
    required this.personbook,
    required this.capacityMin,
  }) : super(
          bookprice: bookprice,
          capacity: capacity,
          imagewids: imagewids,
          personbook: personbook,
          capacityMin: capacityMin,
        );

  final int? bookprice;
  final int? capacity;
  final List<Imagewid> imagewids;
  final int? personbook;
  final int? capacityMin;

  factory DatawiddPOst.fromJson(Map<String, dynamic> json) {
    return DatawiddPOst(
      bookprice: json["bookprice"],
      capacity: json["capacity"],
      imagewids: json["imagewids"] == null
          ? []
          : List<Imagewid>.from(
              json["imagewids"]!.map((x) => Imagewid.fromJson(x))),
      personbook: json["personbook"],
      capacityMin: json["capacityMin"],
    );
  }

  Map<String, dynamic> toJson() => {
        "bookprice": bookprice,
        "capacity": capacity,
        "imagewids": imagewids.map((x) => x.toJson()).toList(),
        "personbook": personbook,
        "capacityMin": capacityMin,
      };
}

class Imagewid extends ImagewidEntity {
  Imagewid({
    required this.id,
  }) : super(id: id);

  final File? id;

  factory Imagewid.fromJson(Map<String, dynamic> json) {
    return Imagewid(
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
      };
}
