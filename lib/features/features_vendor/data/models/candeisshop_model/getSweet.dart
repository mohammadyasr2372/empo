class Getsweet {
  Getsweet({
    required this.success,
    required this.message,
    required this.dataProducts,
  });

  final bool? success;
  final String? message;
  final List<DataProductsSweet> dataProducts;

  factory Getsweet.fromJson(Map<String, dynamic> json) {
    return Getsweet(
      success: json["success"],
      message: json["message"],
      dataProducts: json["DataProducts"] == null
          ? []
          : List<DataProductsSweet>.from(
              json["DataProducts"]!.map((x) => DataProductsSweet.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "DataProducts": dataProducts.map((x) => x?.toJson()).toList(),
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
  final List<SweetImage> sweetImage;
  final int? sweetAmont;
  final int? sweetPrice;
  final String? sweetName;
  final List<String> candshopId;
  final DateTime? createdAt;
  final int? v;

  factory DataProductsSweet.fromJson(Map<String, dynamic> json) {
    return DataProductsSweet(
      id: json["_id"],
      sweetImage: json["sweet_image"] == null
          ? []
          : List<SweetImage>.from(
              json["sweet_image"]!.map((x) => SweetImage.fromJson(x))),
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
        "sweet_image": sweetImage.map((x) => x?.toJson()).toList(),
        "sweet_amont": sweetAmont,
        "sweet_price": sweetPrice,
        "sweet_name": sweetName,
        "candshopId": candshopId.map((x) => x).toList(),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}

class SweetImage {
  SweetImage({
    required this.url,
    required this.id,
  });

  final String? url;
  final String? id;

  factory SweetImage.fromJson(Map<String, dynamic> json) {
    return SweetImage(
      url: json["url"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "_id": id,
      };
}
