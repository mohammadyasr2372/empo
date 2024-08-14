// ignore_for_file: file_names

import 'getcandyShop_model.dart';

class Getsweet {
  Getsweet({
    required this.success,
    required this.message,
    required this.dataProducts,
  });

  final bool? success;
  final String? message;
  final DataProductsSweet? dataProducts;

  factory Getsweet.fromJson(Map<String, dynamic> json) {
    return Getsweet(
      success: json["success"],
      message: json["message"],
      dataProducts: json["DataProducts"] == null
          ? null
          : DataProductsSweet.fromJson(json["DataProducts"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "DataProducts": dataProducts?.toJson(),
      };
}

class DataProductsSweet {
  DataProductsSweet({
    required this.id,
    required this.sweetImage,
    required this.sweetAmont,
    required this.sweetPrice,
    required this.sweetName,
    required this.candshopId,
    required this.createdAt,
    required this.v,
  });

  final String? id;
  final List<CandeImage> sweetImage;
  final int? sweetAmont;
  final int? sweetPrice;
  final String? sweetName;
  final List<String> candshopId;
  final DateTime? createdAt;
  final int? v;

  factory DataProductsSweet.fromJson(Map<String, dynamic> json) {
    return DataProductsSweet(
      id: json["_id"],
      sweetImage: json["cande_image"] == null
          ? []
          : List<CandeImage>.from(
              json["cande_image"]!.map((x) => CandeImage.fromJson(x))),
      sweetAmont: json["sweet_amont"],
      sweetPrice: json["sweet_price"],
      sweetName: json["sweet_name"],
      candshopId: json["candshopId"] == null
          ? []
          : List<String>.from(json["candshopId"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sweet_image": sweetImage.map((x) => x.toJson()).toList(),
        "sweet_amont": sweetAmont,
        "sweet_price": sweetPrice,
        "sweet_name": sweetName,
        "candshopId": candshopId.map((x) => x).toList(),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}
