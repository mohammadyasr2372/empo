import 'package:party/features/features_vendor/data/models/user_model/search_user/get_shopper.dart';

class SearchCity {
  SearchCity({
    required this.success,
    required this.message,
    required this.dataWidding,
    required this.dataHotal,
    required this.dataRestorant,
    required this.datacandshop,
    required this.page,
    required this.nextPage,
    required this.totalPages,
    required this.totalShopper,
  });

  final bool? success;
  final String? message;
  final List<getDataShopper> dataWidding;
  final List<getDataShopper> dataHotal;
  final List<getDataShopper> dataRestorant;
  final List<getDataShopper> datacandshop;
  final int? page;
  final dynamic nextPage;
  final int? totalPages;
  final int? totalShopper;

  factory SearchCity.fromJson(Map<String, dynamic> json) {
    return SearchCity(
      success: json["success"],
      message: json["message"],
      dataWidding: json["dataWidding"] == null
          ? []
          : List<getDataShopper>.from(
              json["dataWidding"]!.map((x) => getDataShopper.fromJson(x))),
      dataHotal: json["dataHotal"] == null
          ? []
          : List<getDataShopper>.from(
              json["dataHotal"]!.map((x) => getDataShopper.fromJson(x))),
      dataRestorant: json["dataRestorant"] == null
          ? []
          : List<getDataShopper>.from(
              json["dataRestorant"]!.map((x) => getDataShopper.fromJson(x))),
      datacandshop: json["datacandshop"] == null
          ? []
          : List<getDataShopper>.from(
              json["datacandshop"]!.map((x) => getDataShopper.fromJson(x))),
      page: json["page"],
      nextPage: json["nextPage"],
      totalPages: json["totalPages"],
      totalShopper: json["totalShopper"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "dataWidding": dataWidding.map((x) => x.toJson()).toList(),
        "dataHotal": dataHotal.map((x) => x.toJson()).toList(),
        "dataRestorant": dataRestorant.map((x) => x).toList(),
        "datacandshop": datacandshop.map((x) => x).toList(),
        "page": page,
        "nextPage": nextPage,
        "totalPages": totalPages,
        "totalShopper": totalShopper,
      };

  map(Map<String, dynamic> Function(dynamic item) param0) {}
}

// class Data {
//     Data({
//         required this.id,
//         required this.email,
//         required this.createdAt,
//         required this.eventName,
//         required this.image,
//     });

//     final String? id;
//     final String? email;
//     final DateTime? createdAt;
//     final String? eventName;
//     final String? image;

//     factory Data.fromJson(Map<String, dynamic> json){ 
//         return Data(
//             id: json["_id"],
//             email: json["email"],
//             createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
//             eventName: json["event_name"],
//             image: json["image"],
//         );
//     }

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "email": email,
//         "createdAt": createdAt?.toIso8601String(),
//         "event_name": eventName,
//         "image": image,
//     };

// }
