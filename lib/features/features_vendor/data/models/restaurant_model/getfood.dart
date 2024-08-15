class Getfood {
  Getfood({
    required this.success,
    required this.message,
    required this.dataProducts,
  });

  final bool? success;
  final String? message;
  final List<DataProduct> dataProducts;

  factory Getfood.fromJson(Map<String, dynamic> json) {
    return Getfood(
      success: json["success"],
      message: json["message"],
      dataProducts: json["DataProducts"] == null
          ? []
          : List<DataProduct>.from(
              json["DataProducts"]!.map((x) => DataProduct.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "DataProducts": dataProducts.map((x) => x?.toJson()).toList(),
      };
}

class DataProduct {
  DataProduct({
    required this.id,
    required this.foodImage,
    required this.foodPrice,
    required this.foodName,
    required this.restorId,
    required this.createdAt,
    required this.v,
  });

  final String? id;
  final List<FoodImage> foodImage;
  final int? foodPrice;
  final String? foodName;
  final List<String> restorId;
  final DateTime? createdAt;
  final int? v;

  factory DataProduct.fromJson(Map<String, dynamic> json) {
    return DataProduct(
      id: json["_id"],
      foodImage: json["food_image"] == null
          ? []
          : List<FoodImage>.from(
              json["food_image"]!.map((x) => FoodImage.fromJson(x))),
      foodPrice: json["food_price"],
      foodName: json["food_name"],
      restorId: json["restorId"] == null
          ? []
          : List<String>.from(json["restorId"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "food_image": foodImage.map((x) => x?.toJson()).toList(),
        "food_price": foodPrice,
        "food_name": foodName,
        "restorId": restorId.map((x) => x).toList(),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}

class FoodImage {
  FoodImage({
    required this.url,
    required this.id,
  });

  final String? url;
  final String? id;

  factory FoodImage.fromJson(Map<String, dynamic> json) {
    return FoodImage(
      url: json["url"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "_id": id,
      };
}
