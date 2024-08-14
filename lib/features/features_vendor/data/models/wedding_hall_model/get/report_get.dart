// // ignore_for_file: overridden_fields

// import '../../../../domain/entities/wedding_hall_entity/get_entity/getwedding.dart';

// class msg_Get_Wedd_hal extends ReportGetEntity {
//   msg_Get_Wedd_hal({
//     required this.success,
//     required this.dataWidding,
//   }) : super(success: success, dataWidding: dataWidding);

//   final bool? success;
//   final GetDataWidding? dataWidding;

//   factory msg_Get_Wedd_hal.fromJson(Map<String, dynamic> json) {
//     return msg_Get_Wedd_hal(
//       success: json["success"],
//       dataWidding: json["DataWidding"] == null
//           ? null
//           : GetDataWidding.fromJson(json["DataWidding"]),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "DataWidding": dataWidding?.toJson(),
//       };
//   ReportGetEntity toEntity() {
//     return ReportGetEntity(
//       success: success,
//       dataWidding: dataWidding,
//     );
//   }
// }

// class GetDataWidding extends GetDataWiddingEntity {
//   GetDataWidding({
//     required this.id,
//     required this.bookprice,
//     required this.capacity,
//     required this.imagewids,
//     required this.personbook,
//     required this.capacityMin,
//     required this.pricetotel,
//     required this.isBooked,
//     required this.shopperId,
//     required this.imagehospit,
//     required this.createdAt,
//     required this.v,
//   }) : super(
//             id: id,
//             bookprice: bookprice,
//             capacity: capacity,
//             imagewids: imagewids,
//             personbook: personbook,
//             capacityMin: capacityMin,
//             pricetotel: pricetotel,
//             isBooked: isBooked,
//             shopperId: shopperId,
//             imagehospit: imagehospit,
//             createdAt: createdAt,
//             v: v);

//   final String? id;
//   final int? bookprice;
//   final int? capacity;
//   final List<Imagewid> imagewids;
//   final int? personbook;
//   final int? capacityMin;
//   final int? pricetotel;
//   final bool? isBooked;
//   final List<String> shopperId;
//   final List<dynamic> imagehospit;
//   final DateTime? createdAt;
//   final int? v;

//   factory GetDataWidding.fromJson(Map<String, dynamic> json) {
//     return GetDataWidding(
//       id: json["_id"],
//       bookprice: json["bookprice"],
//       capacity: json["capacity"],
//       imagewids: json["imagewids"] == null
//           ? []
//           : List<Imagewid>.from(
//               json["imagewids"]!.map((x) => Imagewid.fromJson(x))),
//       personbook: json["personbook"],
//       capacityMin: json["capacityMin"],
//       pricetotel: json["pricetotel"],
//       isBooked: json["is_booked"],
//       shopperId: json["shopperId"] == null
//           ? []
//           : List<String>.from(json["shopperId"]!.map((x) => x)),
//       imagehospit: json["imagehospit"] == null
//           ? []
//           : List<dynamic>.from(json["imagehospit"]!.map((x) => x)),
//       createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
//       v: json["__v"],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "bookprice": bookprice,
//         "capacity": capacity,
//         "imagewids": imagewids.map((x) => x.toJson()).toList(),
//         "personbook": personbook,
//         "capacityMin": capacityMin,
//         "pricetotel": pricetotel,
//         "is_booked": isBooked,
//         "shopperId": shopperId.map((x) => x).toList(),
//         "imagehospit": imagehospit.map((x) => x).toList(),
//         "createdAt": createdAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class Imagewid extends ImagewidEntity {
//   Imagewid({
//     required this.id,
//   }) : super(id: id);

//   final String? id;

//   factory Imagewid.fromJson(Map<String, dynamic> json) {
//     return Imagewid(
//       id: json["_id"],
//     );
//   }

// ignore_for_file: camel_case_types

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//       };
// }
import '../../../../domain/entities/wedding_hall_entity/get_entity/getwedding.dart';

class msg_Get_Wedd_hal {
  msg_Get_Wedd_hal({
    required this.success,
    required this.dataWidding,
  });

  final bool? success;
  final DataWidding? dataWidding;

  factory msg_Get_Wedd_hal.fromJson(Map<String, dynamic> json) {
    return msg_Get_Wedd_hal(
      success: json["success"],
      dataWidding: json["DataWidding"] == null
          ? null
          : DataWidding.fromJson(json["DataWidding"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "DataWidding": dataWidding?.toJson(),
      };
  ReportGetEntity toEntity() {
    return ReportGetEntity(
      success: success,
      dataWidding: null,
    );
  }
}

class DataWidding {
  DataWidding({
    required this.id,
    required this.bookprice,
    required this.capacity,
    required this.imagewids,
    required this.personbook,
    required this.capacityMin,
    required this.shopperId,
    required this.imagehospit,
    required this.createdAt,
    required this.v,
  });

  final String? id;
  final int? bookprice;
  final int? capacity;
  final List<Image> imagewids;
  final int? personbook;
  final int? capacityMin;
  final List<String> shopperId;
  final List<Image> imagehospit;
  final DateTime? createdAt;
  final int? v;

  factory DataWidding.fromJson(Map<String, dynamic> json) {
    return DataWidding(
      id: json["_id"],
      bookprice: json["bookprice"],
      capacity: json["capacity"],
      imagewids: json["imagewids"] == null
          ? []
          : List<Image>.from(json["imagewids"]!.map((x) => Image.fromJson(x))),
      personbook: json["personbook"],
      capacityMin: json["capacityMin"],
      shopperId: json["shopperId"] == null
          ? []
          : List<String>.from(json["shopperId"]!.map((x) => x)),
      imagehospit: json["imagehospit"] == null
          ? []
          : List<Image>.from(
              json["imagehospit"]!.map((x) => Image.fromJson(x))),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "bookprice": bookprice,
        "capacity": capacity,
        "imagewids": imagewids.map((x) => x.toJson()).toList(),
        "personbook": personbook,
        "capacityMin": capacityMin,
        "shopperId": shopperId.map((x) => x).toList(),
        "imagehospit": imagehospit.map((x) => x.toJson()).toList(),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}

class Image {
  Image({
    required this.url,
    required this.id,
  });

  final String? url;
  final String? id;

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      url: json["url"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "_id": id,
      };
}
